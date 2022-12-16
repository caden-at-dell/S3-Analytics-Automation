oc delete -f scripts/01-deploySQL.yaml
{
repl_name=$(oc get rs | grep new-sql | awk '{ print $1 }')
oc delete replicaset $repl_name
pod_name=$(oc get pods | grep new-sql | awk '{ print $1 }')
oc delete pod $pod_name
}