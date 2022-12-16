# Deploy SQL Server 
echo "Deploying SQL Server"
oc create -f scripts/01-deploySQL.yaml > autoDeploy.log
sleep 10
#
# Verify pod status to become running
echo "Verify pod status"
pod_status=$(oc get pods | grep new-sql | awk '{ print $3 }')
until [ "$pod_status" = "Running" ]; do
   sleep 2
   pod_status=$(oc get pods | grep new-sql | awk '{ print $3 }')
done
echo "pod is ready..."
#
#Copy test database backup files to the container
echo "Copy test database backup files to the container"
pod_name=$(oc get pods | grep new-sql | awk '{ print $1 }')
oc cp bkp/WideWorldImporters-Full.bak $pod_name:/var/opt/mssql/
oc cp bkp/WideWorldImportersDW-Full.bak $pod_name:/var/opt/mssql/
#
# Wait for SQL Server instance to be fully initialized
echo "Wait for SQL Server instance to be fully initialized"
sleep 15
#
echo "Restoraing Databases in SQL Server instance"
sqlcmd -S 10.230.87.246,31445 -U SA -P @Vantage4 -i scripts/01-restoredb.sql >> autoDeploy.log
#
echo "Creating and configuring ECS S3 credential in SQL Server"
sqlcmd -S 10.230.87.246,31445 -U SA -P @Vantage4 -i scripts/02-setup_s3_connectivity.sql >> autoDeploy.log
#
# Recreate SQL Server pod
pod_name=$(oc get pods | grep new-sql | awk '{ print $1 }')
oc delete pod $pod_name
pod_status=$(oc get pods | grep new-sql | awk '{ print $3 }')
until [ "$pod_status" = "Running" ]; do
   sleep 2
   pod_status=$(oc get pods | grep new-sql | awk '{ print $3 }')
done
echo "pod is ready..."
#
echo "Configuring ECS S3 polybase in SQL Server"
sqlcmd -S 10.230.87.246,31445 -U SA -P @Vantage4 -i scripts/03-setupPolybase.sql >> autoDeploy.log
#
echo "Converting csv file to parquet files using CETAS and OPENROWSET..."
sqlcmd -S 10.230.87.252,31445 -U SA -P @Vantage4 -i scripts/04-convertCsvToParquetUsingCETAS.sql >> autoDeploy.log
#
echo "Setting helper view in the database..."
sqlcmd -S 10.230.87.246,31445 -U SA -P @Vantage4 -i scripts/05-setupViews.sql >> autoDeploy.log
#
