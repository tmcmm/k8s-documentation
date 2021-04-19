# Az Commands

## Kubernetes related

__list all your clusters under subscription:__
```
az aks list -o table
```
__list cluster nodepool:__
```
az aks nodepool list --resource-group <Resource_Group> --cluster-name <Cluster_name>
```
__get cluster credentials:__
```
# truncate the kube config files:
truncate -s0 ~/.kube/config
az aks get-credentials --resource-group <Resource_Group> --name <Cluster_name> --overwrite-existing -f ~/.kube/config
```
__get available upgrades:__<br>
supported versions:<br>
```
az aks get-versions --location <location> -o table
```
```
 az aks get-upgrades --resource-group <Resource_Group> --name <Cluster_name> --output table
```
__to upgrade the node pools:__
```
az aks nodepool update -n <nodepoolname> --cluster-name <cluster name> -g <rgname> --max-surge 5
az aks nodepool upgrade -n <nodepoolname> --cluster-name <cluster name> -g <rgname> --kubernetes-version <1.xx.xx>
```

__upgrade AKS cluster (only control plane):__
```
az aks upgrade --kubernetes-version <1.xx.xx> -n <cluster name> -g <rgname> --control-plane-only
```
__upgrade the cluster:__[Azure AKS upgrade Homepage](https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#upgrade-an-aks-cluster "Azure AKS Upgrade")<br>
```
az aks upgrade --resource-group myResourceGroup --name myAKSCluster --kubernetes-version KUBERNETES_VERSION
```
__check the version of the cluster by running the following command:__
```
az aks show -g <rgname> -n <cluster name> -o table
```
__check the version of the worker nodes inside cluster:__
```
az aks nodepool show --cluster-name vnodes -g vnodes -n agentpool
```
__create nodepool with conteinerd:__
```
az aks nodepool add --name <node_pool_name> --cluster-name <cluster_name> --resource-group <resource_group> --aks-custom-headers CustomizedUbuntu=aks-ubuntu,ContainerRuntime=containerd --kubernetes-version=1.16.13
```

__reconcile cluster:__
```
az resource update --resource-group <Resource_Group> --name <Cluster_name> --namespace Microsoft.ContainerService -- resource-type ManagedClusters
```
__stop cluster:__
```
az aks stop --resource-group <Resource_Group> --name <Cluster_name>
```
__start cluster:__
```
az aks start --resource-group <Resource_Group> --name <Cluster_name>
```
__get cluster certificates vaildity:__
```
kubectl config view --raw -o jsonpath="{.clusters[?(@.name == 'myAKSCluster')].cluster.certificate-authority-data}" | base64 -d | openssl x509 -text | grep -A2 Validity
```
__rotate Certificates:__
```
az aks rotate-certs -g $RESOURCE_GROUP_NAME -n $CLUSTER_NAME
```

__after rotating certificates:__
```
az aks get-credentials -g akslab -n akstmcmm-14227 --overwrite-existing
```
__create cluster with uptime sla:__
```
az aks create --resource-group myResourceGroup --name myAKSCluster --uptime-sla (...)
```
__update cluster to uptime sla:__
```
 az aks update --resource-group myResourceGroup --name myAKSCluster --uptime-sla
```
__remove uptime sla:__
```
 az aks update --resource-group myResourceGroup --name myAKSCluster --no-uptime-sla
```

### Launch a command directly from any node instance:
__list available vmss:__
```
az vmss list -o table
```
__Launch a command in a specific node instance:__
```
az vmss run-command invoke -g <Resource_group> -n <Node_Instance> --command-id RunShellScript --instance-id 0 --scripts "ping microsoft.com" -o json | jq ".value[].message"
```
__Get kubelet logs:__
```
az vmss run-command invoke -g MC_RG-AKS(..) -n aks-usernpool-(...)-vmss --command-id RunShellScript --instance-id 0 --scripts "sudo journalctl -u kubelet -o cat" -o json | jq ".value[].message" > logs.log
```
__Create alias in your bash_profile:__
alias azvmssrun='_azvmssrun(){ az vmss run-command invoke -g "$1" -n "$2" --command-id RunShellScript --instance-id 0 --scripts "nc -vz "$3" "$4"" -o json | jq ".value[].message";}; _azvmssrun'


## VM related
__Get all your vm on your subscription:__
```
az vm list -o table
```

__Create alias in your bash_profile:__
```
alias azvmpublickey='_azvmpublickey(){ az vm show -g "$1" -n "$2" --query "{VMName:name, admin:osProfile.adminUsername, sshKey:osProfile.linuxConfiguration.ssh.publicKeys[0].keyData }" -o json ;}; _azvmpublickey'
```

## Account Related
__list resource_groups:__
```
az group list -o table
```
__delete resource_groups:__
```
az group delete --name
```
__List all your sp created under your susbcription:__
```
az ad sp list --show-mine --query "[].{id:appId, tenant:appOwnerTenantId, name:displayName}
```
__kubernetes check ServicePrincipalId:__
```
az aks list --resource-group <Resource_Group> --query="[0].servicePrincipalProfile.clientId"
```
__get service principal end Date:__
```
az ad sp credential list --id <clientid> --query "[].endDate" -o tsv
```
__create a new service principal__:
```
az ad sp create-for-rbac \
    --name $AKS_SP_NAME \
    --skip-assignment >> sp-credentials-deploy.yaml 2>&1
```
__retrieve Service principal APPID and Client Secret:__
```
AKS_SP_APP_ID=$(az ad app list --display-name $AKS_SP_NAME --query "[].appId" -o tsv)
AKS_SP_SECRET=$(az ad sp credential reset --name $AKS_SP_NAME --query "password" -o tsv)
```
__add SP to a new cluster:__
```
az aks create --resource-group $RG_NAME --name $CLUSTER_NAME \
    --service-principal $AKS_SP_APP_ID \
    --client-secret $AKS_SP_SECRET \
    --node-count $NODE_COUNT \
    --node-vm-size Standard_DS2_v2 \
 (....)
```
__add SP to a existing cluster:__
```
az aks update-credentials \
--resource-group myResourceGroup \
--name myAKSCluster \  
--reset-service-principal \  
--service-principal $AKS_SP_APP_ID \  
--client-secret $AKS_SP_SECRET
```



__add extensions to azure cli and configure node pools of aks cluster:__
```
az extension add --name aks-preview
az extension update --name aks-preview
az feature register --namespace "Microsoft.ContainerService" --name "CustomNodeConfigPreview"
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/CustomNodeConfigPreview')].{Name:name,State:properties.state}"
```

__list all resources of the resource group:__
```
az resource list --query "[?resourceGroup=='akslab'].{ name: name, flavor: kind, resourceType: type, region: location }" --output table
```

__azure list all subscriptions:__
```
az account list --output table
```
__azure set specific subscriptions:__
```
az account set --subscription "My Demos"
```
__azure run command for a specific subscription:__
```
az vm create --subscription "My Demos" --resource-group MyGroup --name NewVM --image Ubuntu
```


## ACR related
__azure list podsecuritypolicy:__
```
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/PodSecurityPolicyPreview')].{Name:name,State:properties.state}"
```

__list all container ips on ACI:__
az container list -g <resourcegroup> --query '[].{Name:name, IpAddress:ipAddress.ip}' --output tsv

__show all container ips on a sub-net network:__
```
az network vnet show -g <resourcegroup> -n <vnetName> --query '[subnets[].ipConfigurationProfiles[].id[], subnets[].ipConfigurations[].id[]]' -o json
```
__Login on azure acr:__
```
az acr login -n tmcmmregistry --expose-token
docker login tmcmmregistry.azurecr.io -u 00000000-0000-0000-0000-000000000000 -p <token>
```

__check if provider is registered:__
```
az provider list --query "[?contains(namespace,'Microsoft.ContainerInstance')]" -o table
```

__list images in azure container registry:__
```
az acr repository list --name <acrName> --output table
```
__get registry credentials:__
```
az acr show --name tmcmmregistry --query loginServer
```

## Network Related

__azure get subnet id:__
```
az network vnet subnet show -g <myResourceGroup> --vnet-name <myVnetName> --name <mySubnetName> --query id -o tsv ;}; _azsubnetid'
```
__azure get vnet id:__
```
alias azbnetid='_aznetid(){ az network vnet subnet show -g <myResourceGroup> --name <myVnetName> --query id -o tsv ;}; _aznetid'
```
__get used ips of a subnet:__
```
az network vnet subnet show -g <myResourceGroup> --vnet-name <myVnetName> --name <mySubnetName> | grep ipconfig | wc -l) | bc
```

## Curl command

__curl command:__
```
for ((i = 0; i < 10; i++)); do curl -o /dev/null -s "www.microsoft.com" -w "Connect %{time_connect}s, Start Transfer %{time_starttransfer}s Total %{time_total}s\n"; done
```
__using bash alias:__
```
alias curltime='_curltime(){ for ((i = 0; i < 10; i++)); do curl -o /dev/null -s $1 -w "Connect %{time_connect}s, Start Transfer %{time_starttransfer}s Total %{time_total}s\n"; done ;}; _curltime'
```
