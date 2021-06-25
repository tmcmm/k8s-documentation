# Az Commands

## Kubernetes related

__List all your clusters under subscription:__
```
az aks list -o table
```
__List cluster nodepool:__
```
az aks nodepool list --resource-group <Resource_Group> --cluster-name <Cluster_name>
```
__Scale cluster nodepool:__
```
az aks nodepool scale --cluster-name --name --resource-group--no-wait --node-count 4
```
__Get cluster credentials:__
```
# truncate the kube config files:
truncate -s0 ~/.kube/config
az aks get-credentials --resource-group <Resource_Group> --name <Cluster_name> --overwrite-existing -f ~/.kube/config
```
### Upgrade Custer<br>
During the upgrade process, AKS will:<br>

- Add a new buffer node (or as many nodes as configured in max surge) to the cluster that runs the specified Kubernetes version.<br>
- Cordon and drain one of the old nodes to minimize disruption to running applications (if you're using max surge it will cordon and drain as many nodes at the same time as the number of buffer nodes specified).<br>
- When the old node is fully drained, it will be reimaged to receive the new version and it will become the buffer node for the following node to be upgraded.<br>
- This process repeats until all nodes in the cluster have been upgraded.<br>
- At the end of the process, the last buffer node will be deleted, maintaining the existing agent node count and zone balance.<br>

__Get available upgrades:__<br>
__Supported versions:__<br>
```
az aks get-versions --location <location> -o table
```
```
 az aks get-upgrades --resource-group <Resource_Group> --name <Cluster_name> --output table
```
__To upgrade the node pools:__
```
az aks nodepool update -n <nodepoolname> --cluster-name <cluster name> -g <rgname> --max-surge 5
az aks nodepool upgrade -n <nodepoolname> --cluster-name <cluster name> -g <rgname> --kubernetes-version <1.xx.xx>
```

__Upgrade AKS cluster (only control plane):__
```
az aks upgrade --kubernetes-version <1.xx.xx> -n <cluster name> -g <rgname> --control-plane-only
```
__Upgrade the cluster:__[Azure AKS upgrade Homepage](https://docs.microsoft.com/en-us/azure/aks/upgrade-cluster#upgrade-an-aks-cluster "Azure AKS Upgrade")<br>
```
az aks upgrade --resource-group myResourceGroup --name myAKSCluster --kubernetes-version KUBERNETES_VERSION
```
__Check the version of the cluster by running the following command:__
```
az aks show -g <rgname> -n <cluster name> -o table
```
__Check the version of the worker nodes inside cluster:__
```
az aks nodepool show --cluster-name vnodes -g vnodes -n agentpool
```
__Create nodepool with conteinerd:__
```
az aks nodepool add --name <node_pool_name> --cluster-name <cluster_name> --resource-group <resource_group> --aks-custom-headers CustomizedUbuntu=aks-ubuntu,ContainerRuntime=containerd --kubernetes-version=1.16.13
```
### Cluster pending in upgrading state:
Refresh the service principle using the same secret to get the cluster back to succeeded state.<br>
Retrieve the secret by running this command on any node:<br>
```
az vm run-command invoke -g <nodeResourceGroup> -n <VM Name> --scripts "cat /etc/kubernetes/azure.json" --command-id RunShellScript
az vmss run-command invoke -g <Resource_group> -n <Node_Instance> --command-id RunShellScript --instance-id 0 --scripts "cat /etc/kubernetes/azure.json" -o json | jq ".value[].message"
```
!!! note "Note"

    Make sure that you do not create a new secret. You have to use the same one obtained from the above step.

Update the cluster credentials using the service principal ID and secret from the above step.<br>
```
az aks update-credentials --reset-service-principal --service-principal <SP_ID> --client-secret <SP_Secret> -g <myResourceGroup> -n <myAKSCluster>
```
__Reconcile cluster:__
```
az resource update --resource-group <Resource_Group> --name <Cluster_name> --namespace Microsoft.ContainerService --resource-type ManagedClusters
```
### Cluster Actions:
[Azure AKS stop & start](https://docs.microsoft.com/en-us/azure/aks/start-stop-cluster "Azure AKS Stop & Start")<br>


__Stop cluster:__
```
az aks stop --resource-group <Resource_Group> --name <Cluster_name>
```
__Start cluster:__
```
az aks start --resource-group <Resource_Group> --name <Cluster_name>
```
__Restart vmss__:
```
az vmss restart -g MC_(...) -n <vmss_name> --instance-ids 2
```
__What if a node can't be restarted?__
```
# De-allocate the VM
az vmss deallocate -g MC_(...) -n <vmss_name> --instance-ids 2

# Start the deallocated VM again
az vmss start -g MC_(...) -n <vmss_name> --instance-ids 2
```

__Get cluster certificates vaildity:__
```
kubectl config view --raw -o jsonpath="{.clusters[?(@.name == 'myAKSCluster')].cluster.certificate-authority-data}" | base64 -d | openssl x509 -text | grep -A2 Validity
```
__Rotate Certificates:__<br>
[azure-certificates-aks](https://docs.microsoft.com/pt-pt/azure/aks/certificate-rotation "Azure Certicates AKS")<br>
```
az aks rotate-certs -g $RESOURCE_GROUP_NAME -n $CLUSTER_NAME
```

__After rotating certificates:__
```
az aks get-credentials -g $RESOURCE_GROUP_NAME -n $CLUSTER_NAME --overwrite-existing
```
__Create cluster with uptime sla:__
```
az aks create --resource-group myResourceGroup --name myAKSCluster --uptime-sla (...)
```
__Update cluster to uptime sla:__<br>
When we change to SLA to paid, it creates aditional API Servers to balance load:<br>
[azure-aks-uptime-SLA](https://docs.microsoft.com/en-us/azure/aks/uptime-sla#modify-an-existing-cluster-to-use-uptime-sla "Azure AKS Uptime SLA")<br>
__Cost: Uptime SLA	$0.10 per cluster per hour__<br>
```
 az aks update --resource-group myResourceGroup --name myAKSCluster --uptime-sla
```
__Remove uptime sla:__
```
 az aks update --resource-group myResourceGroup --name myAKSCluster --no-uptime-sla
```
## Api Server Cases:
__Check available vmss instances:__
```
az vmss list-instances -g Node_Resource_Group -n aks-(...)-vmss -o table
```
__Check for API Server communication:__
```
az vmss run-command invoke -g Node_Resource_Group -n aks-(..)-vmss --command-id RunShellScript --instance-id 6 --scripts "nc -vz  -w 2 FQDN 443" -o json
```
__Check for the required ports:__<br>
[azure-aks-egress](https://docs.microsoft.com/en-us/azure/aks/limit-egress-traffic "Azure Required Ports AKS")<br>
```
az vmss run-command invoke -g Node_Resource_Group -n aks-(..)-vmss --command-id RunShellScript --instance-id 6 --scripts "nc -vz  -w 2 FQDN 9000" -o json
```
```
az vmss run-command invoke -g Node_Resource_Group -n aks-(..)-vmss --command-id RunShellScript --instance-id 6 --scripts "nc -vz  -w 2 FQDN 1194" -o json
```
__Delete tunnel-front-pod:__
```
kubectl delete po -l component=tunnel -n kube-system
```
When the nodes are not in ready state then it would be a communication issue with the API server for which you can verify the following:<br>

• Route table<br>

• DNS resolution on the DNS servers<br>

• NSG<br>

If nothing seems to resolve, restart API Server.<br>

### Launch a command directly from any node instance:
__list available vmss:__
```
az vmss list -o table
```
__Launch a command in a specific node instance:__
```
az vmss run-command invoke -g <Node_Resource_Group> -n <Node_Instance> --command-id RunShellScript --instance-id 0 --scripts "nc -vz FQDN 443" -o json | jq ".value[].message"
```
__If windows node pool__
```
az vmss run-command invoke -g <Node_Resource_Group> -n <Node_Instance> --command-id RunPowerShellScript --instance-id 0 --scripts "netsh advfirewall set currentprofile state off" -o json
```

__If Availability Set:__
```
az vm run-command invoke -g <nodeResourceGroup> -n <VM Name> --scripts "hostname && date && cat /etc/kubernetes/azure.json" --command-id RunShellScript
```
__Get kubelet logs:__
```
az vmss run-command invoke -g MC_RG-AKS(..) -n aks-usernpool-(...)-vmss --command-id RunShellScript --instance-id 0 --scripts "sudo journalctl -u kubelet -o cat" -o json | jq ".value[].message" > logs.log
```
__Restart Kubelet:__
```
az vm run-command invoke -g <nodeResourceGroup> -n <VM Name> --scripts "systemctl restart kubelet" --command-id RunShellScript -o json
```

__Create alias in your bash_profile:__
alias azvmssrun='_azvmssrun(){ az vmss run-command invoke -g "$1" -n "$2" --command-id RunShellScript --instance-id 0 --scripts "nc -vz "$3" "$4"" -o json | jq ".value[].message";}; _azvmssrun'


## VM related
__Get all your vm on your subscription:__
```
az vm list -o table
```
__List available vmss:__
```
az vmss list -o table
```
__List all instances into the nodepool:__
```
az vmss list-instances -g Node_Resource_Group -n aks-(...)-vmss -o table
```
__Delete nodepool:__
```
az vmss delete --name --resource-group --no-wait
```
```
 az vmss delete-instances --resource-group myResourceGroup --name myScaleSet --instance-ids 0
```
__Check available Sku's under location:__
```
az vm list-skus --location ukwest --size Standard_B --all --output table ResourceType Locations Name Zones
```
__Create alias in your bash_profile:__
```
alias azvmpublickey='_azvmpublickey(){ az vm show -g "$1" -n "$2" --query "{VMName:name, admin:osProfile.adminUsername, sshKey:osProfile.linuxConfiguration.ssh.publicKeys[0].keyData }" -o json ;}; _azvmpublickey'
```
__Get VM private ip__
```
az vm list-ip-addresses --query "[?virtualMachine.name=='vm_name']"
alias azvmprivateip='_azvmprivateip(){ az vm list-ip-addresses --query "[?virtualMachine.name=="$1"]" -o json ;}; _azvmprivateip
```
## Account Related


__List all resources of the resource group:__
```
az resource list --query "[?resourceGroup=='akslab'].{ name: name, flavor: kind, resourceType: type, region: location }" --output table
```
__Azure list all subscriptions:__
```
az account list --output table
```
__Azure set specific subscriptions:__
```
az account set --subscription "My Demos"
```
__Azure run command for a specific subscription:__
```
az vm create --subscription "My Demos" --resource-group MyGroup --name NewVM --image Ubuntu
```
__List resource_groups:__
```
az group list -o table
```
__Delete resource_groups:__
```
az group delete --name
```
__List all your sp created under your susbcription:__
```
az ad sp list --show-mine --query "[].{id:appId, tenant:appOwnerTenantId, name:displayName}"
```
__Assign Contributor role to the VNET/SUBNET on the SP_ID:__
```
az role definition list --query "[].{name:name, roleType:roleType, roleName:roleName}" --output tsv
az group list --query "[].{name:name}" --output tsv
az role definition list --name "Contributor"
VNET_ID=$(az network vnet show --resource-group myResourceGroup --name myAKSVnet --query id -o tsv)
SUBNET_ID=$(az network vnet subnet show --resource-group myResourceGroup --vnet-name myAKSVnet --name myAKSSubnet --query id -o tsv)
az role assignment create --assignee <appId> --scope $VNET_ID --role "Network Contributor"
```
### Reset the SP Credentials

[azure-aks-sp-reset](https://docs.microsoft.com/en-us/azure/aks/update-credentials#reset-the-existing-service-principal-credential "Reset existing Service Principal Credential")<br>

__Kubernetes check ServicePrincipalId:__
```
az aks list --resource-group <Resource_Group> --query="[0].servicePrincipalProfile.clientId"
```
__Get service principal end Date:__
```
az ad sp credential list --id <clientid> --query "[].endDate" -o tsv
```
__Retrieve Sp secret password:__
```
az vmss run-command invoke --command-id RunShellScript --resource-group <nodeRG> --name <vmssName> --instance-id <0,1,2...> --scripts "hostname && date && cat /etc/kubernetes/azure.json" | grep aadClientSecret
```
__if AvailabilitySet:__
```
az vm run-command invoke -g <nodeResourceGroup> -n <VM Name> --scripts "hostname && date && cat /etc/kubernetes/azure.json" --command-id RunShellScript | grep aadClientSecret
```
__Now that we have the SP appID and password we can reset the SP password expiration date with Azure cli, the command is as follows:__<br>
```
az ad sp credential reset -n <appIDofSP> -p <passwordofSP> --years <NunmberOfYears>
```
__Create a new service principal__:
```
az ad sp create-for-rbac \
    --name $AKS_SP_NAME \
    --skip-assignment >> sp-credentials-deploy.yaml 2>&1
```
__Reset existing Service principal APPID and Client Secret:__
```
AKS_SP_NAME=$(az ad sp list --show-mine --query "[].{id:appId, tenant:appOwnerTenantId, name:displayName}"
AKS_SP_APP_ID=$(az ad app list --display-name "$AKS_SP_NAME" --query "[].appId" -o tsv)
AKS_SP_SECRET=$(az ad sp credential reset --name $AKS_SP_NAME --query "password" -o tsv)
```
__Add SP to a new cluster:__
```
az aks create --resource-group $RG_NAME --name $CLUSTER_NAME \
    --service-principal $AKS_SP_APP_ID \
    --client-secret $AKS_SP_SECRET \
    --node-count $NODE_COUNT \
    --node-vm-size Standard_DS2_v2 \
 (....)
```
__Add SP to a existing cluster:__
```
az aks update-credentials \
--resource-group myResourceGroup \
--name myAKSCluster \  
--reset-service-principal \  
--service-principal $AKS_SP_APP_ID \  
--client-secret $AKS_SP_SECRET
```
### Using Azure Portal:

• Using the Azure portal navigate to Azure AD, then "App registrations" and create a new Service Principal.
• Then create a password for this new SP in the "Certificates and secrets" section
• Once you hit "Save" the password will be shown just once, have the customer save it somewhere.

__After run from az-cli:__
```
az aks update-credentials -g <clusterResourceGroup> -n <clusterName> --reset-service-principal --service-principal <appIDofNewSP> --client-secret <PasswordofNewSP>
```

__Add extensions to azure cli and configure node pools of aks cluster:__
```
az extension add --name aks-preview
az extension update --name aks-preview
az feature register --namespace "Microsoft.ContainerService" --name "CustomNodeConfigPreview"
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/CustomNodeConfigPreview')].{Name:name,State:properties.state}"
```

## ACR related
__Azure list podsecuritypolicy:__
```
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/PodSecurityPolicyPreview')].{Name:name,State:properties.state}"
```

__List all container ips on ACI:__
```
az container list -g <resourcegroup> --query '[].{Name:name, IpAddress:ipAddress.ip}' --output tsv
```
__Show all container ips on a sub-net network:__
```
az network vnet show -g <resourcegroup> -n <vnetName> --query '[subnets[].ipConfigurationProfiles[].id[], subnets[].ipConfigurations[].id[]]' -o json
```
__Login on azure acr:__
```
az acr login -n tmcmmregistry --expose-token
docker login tmcmmregistry.azurecr.io -u 00000000-0000-0000-0000-000000000000 -p <token>
```

__Check if provider is registered:__
```
az provider list --query "[?contains(namespace,'Microsoft.ContainerInstance')]" -o table
```

__List images in azure container registry:__
```
az acr repository list --name <acrName> --output table
```
__Get registry credentials:__
```
az acr show --name <acrName> --query loginServer
```

## Network Related

__Azure get subnet id:__
```
az network vnet subnet show -g <myResourceGroup> --vnet-name <myVnetName> --name <mySubnetName> --query id -o tsv ;}; _azsubnetid'
```
__Azure get vnet id:__
```
alias azbnetid='_aznetid(){ az network vnet subnet show -g <myResourceGroup> --name <myVnetName> --query id -o tsv ;}; _aznetid'
```
__Get used ips of a subnet:__
```
az network vnet subnet show -g <myResourceGroup> --vnet-name <myVnetName> --name <mySubnetName> | grep ipconfig | wc -l) | bc
```
__Increase public ip count:__
```
az aks update --resource-group myResourceGroup --name myAKSCluster --load-balancer-managed-outbound-ip-count 2
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

