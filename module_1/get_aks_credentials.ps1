
# these might change. Check the variables.tf file for current values
$rgName = "kubernetes"
$clusterName = "kubernetes_cluster"

az aks get-credentials --resource-group $rgName --name $clusterName
