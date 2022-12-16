# Check if namespace already exists
oc get ns demo

# If namespace doesn't exists crete using below command
# oc create ns demo

# check all objects present in demo namespace
oc get all -n demo

# deploy SQL Server
oc create -f 01-deploySQL.yaml

# Verify deployment
oc get all -n demo

# Copy backup file to sql container
pod_name=$(oc get pods | grep new-sql | awk '{ print $1 }')
oc cp bkp/WideWorldImporters-Full.bak $pod_name:/var/opt/mssql/
oc cp bkp/WideWorldImportersDW-Full.bak $pod_name:/var/opt/mssql/
