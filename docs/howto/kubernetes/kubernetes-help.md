# Kubernetes Documentation Page

> **Kubernetes** is a platform created for the management of container applications

## What is kubernetes?

Kubernetes (K8s) is an open-source system for automating deployment,
scaling, and management of containerized applications. It groups
containers that make up an application into logical units for easy
management and discovery. Kubernetes builds upon 15 years of experience
of running production workloads at Google, combined with best-of-breed
ideas and practices from the community.

**Planet Scale**: Designed on the same principles that allows Google to
run billions of containers a week, Kubernetes can scale without
increasing your ops team.

**Never Outgrow**: Whether testing locally or running a global
enterprise, Kubernetes flexibility grows with you to deliver your
applications consistently and easily no matter how complex your need is.

**Run Anywhere**: Kubernetes is open source giving you the freedom to
take advantage of on-premises, hybrid, or public cloud infrastructure,
letting you effortlessly move workloads to where it matters to you.

## How does kubernetes works?

**Kubernetes** as several components working at the same time. Some of
the components worth noticing are:

-   ***containers***

-   ***pods***

-   ***deployments***

-   ***services***

-   ***ingressess***

The image below, shows how all this components interact with each other

![k8s architecture](./assets/images/k8s-architecture.png)

We will now explain all the components in detail.

> **Note**
>
> There are other components not referenced here. HPA can be used to
> autoscale deployments. There are jobs, cronjobs, daemonsets, etc..

### Containers

**Container** is the most basic component in a kubernetes cluster. The
**container** as the application itself. It’s made to run in a
**docker** environment and is isolated from other containers running in
the same node.

**Containers** can range from a fully running application server we want
to continually run and monitor to a simple batch job we intend to run
only once.

**Containers** have their own operative system so they can run in any
node with **docker** installed.

> **Note**
>
> It’s important to note an application might use several containers

### Pods

**Pod** is an aggregation unit and the first component in a kubernetes
structure. **Applications** might have one or more **containers** and
those closely coupled **containers** are placed under the same **pod**.

**Containers** inside a **pod** can see each other *(like docker
containers in the same network)* and share the same resources. **Pods**
can have limited resources and run in isolation so they wont affect
other pods.

**Pods** can run for just a few moments (batch jobs, cron jobs, etc..)
or stay up (server) until it’s requested to go down.

**Pods** can be run directly without a deployment.

### Deployments

**Deployment** is another aggregation unit that controls where pods run
inside the cluster. **Deployments** can have one or more **pods**.
**Deployments** controls the amount of replicas of the same **pod**.

With a **deployment** you can choose the amount of replicas for a
certain **pod** to be ran on the cluster. We can choose the affinity of
the **pods** for certain nodes (**pods** prefer to be ran with high
affinity nodes).

**Deployments** will restart any **pod** that fails, they respect a
predefined redeploy order and can maintain a maximum availability.

### Services

**Services** expose the **containers** inside the **pods** of a specific
deployment. Those services can expose the services internally (ex:
**ClusterIP**) or externally (ex: **NodePort**). Applications on the
cluster can access other deployments by using the service name/ip and
the exposed port.

### Ingresses

**Ingress** is one way to expose a **deployment** outside of the
cluster. It uses a **service** exposed internally using **ClusterIP**
and exposes it externally on a specific endpoint.

The **ingress** used by default is the nginx-ingress wich is a L7 load
balancer that balances load to the **service** inside the cluster


## Choose a candidate (Azure)

![k8s candidate](./assets/images/candidate.png)

## Kubernetes ARM Kernel

![k8s kernel](./assets/images/kubernetes_arm_kernel.png)

## Kubernetes Cheat Sheet

## Autocomplete

__Kubectl Autocomplete:__
```
source <(kubectl completion bash) 
```
__To add it to your bash shell permanently:__
```
echo "source <(kubectl completion bash)" >> ~/.bashrc
```

## Kubectl Config and Contexts
__Configuration:__
```
kubectl config view 
```
__Export KUBECONFIG var pointing to another kubeconfig file in order to use multiple files:__
```
export KUBECONFIG=~/.kube/config:~/.kube/kubconfig2 
kubectl config view
```

__Get password for user e2e:__
```
kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}'
```
```
kubectl config view -o jsonpath='{.users[].name}'    # get first user
kubectl config view -o jsonpath='{.users[*].name}'   # get list of users
kubectl config get-contexts                          # get list of contexts
kubectl config current-context                       # get current context 
kubectl config use-context my-cluster-name           # use my-cluster-name as current context
```

__Add new cluster to kubeconfig file that supports basic authentication:__
```
kubectl config set-credentials kubeuser/foo.kubernetes.com --username=kubeuser --password=kubepassword
```
__Get ca -certificate:__
```
 kubectl config view --minify --raw --output 'jsonpath={..cluster.certificate-authority-data}'
(..)h1Y1NHSEljYS9zcGpxc0ZsZTNnM3NZeWRRTjltUHJDZ0ZzSXQKNVE1S0I1UzYxS0VnTHJnTDNPd2FT(--)
```
__Get cluster certificate in cer format:__
```
kubectl config view --minify --raw --output 'jsonpath={..cluster.certificate-authority-data}' | base64 -D | openssl x509 -text -out -

-----BEGIN CERTIFICATE-----
MIIFMjCCAxqgAwIBAgIQSrgQdZFOuaRNd0Q95JmU2TANBgkqhkiG9w0BAQsFADAZ
MRcwFQYDVQQDEw5HcnVwb0NHRFJvb3RDQTAeFw0wOTA0MDgxNDU0MjBaFw0zNjA1
MDQxNDI4MThaMBkxFzAVBgNVBAMTDkdydXBvQ0dEUm9vdENBMIICIjANBgkqhkiG
9w0BAQEFAAOCAg8AMIICCgKCAgEAqIsmvDwTzb3rlb08G1xgaa3644z29LKQqSkJ
euPzr0xZ4+tUkIGupIYjxL8mWL8nfNsbihltnOnA1qzhZXIs8+vdqPdsShIQOwrF
GXsZwlvlRAoIkyoZpQxPjbrz3UgcKE5Y1aqBAQCsVcKjsxuCakISoR/daXV2QJX/
V7hT4sF9K8qnC/exp0uWcnuorQjKtqlfr9HQMC9HnihpGocV1lo4OLXdqbG/Rux/
BllnYqDdj8YZQKD2hBsJUZP2xUTo9F5NUY/Mta9ubjHuphxPUYVAnnLpG4xAgvRX
IEH4f/GoJ/FEXN8ozFVeRmnJ/XYtL7vJ0ot5rsVVrF+7mAIT7OC04uMn6exZMI13
143fwu/rHKjNhxy/t2c5TumuDktfHeqSvfcwDBU7znaqVLhSz1k488z733b/O2yn
1asA9bV/bDGUwhTTZJhZQOXHlN9tyfjRuLZP1Jljq3wJqpw+YcbxBfpuYIRJPWCd
1owYgtgQBi0zqJ7mMeFsvpqSRNasBchUm2wBBDYC2QW9KXzKv5fjAGR3ea5IcvaU
DUio2Vy23QGh4ffqwGQqscGu6fbEUZHtdI2Ue5VREuvN3a7NtM0KYrVFFZOcmRHY
oUlbecUN52jt/0r08xH2HNaBZLsV6LxrpY6qIpRfOr61lOA1D6YmsSgdmHHCzFMh
Gn9FOGsCAwEAAaN2MHQwCwYDVR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHQYD
VR0OBBYEFCSpjA3GccA8ofrmPVEMzSmxvuG2MBAGCSsGAQQBgjcVAQQDAgEBMCMG
CSsGAQQBgjcVAgQWBBR5zLUxC40YPF0eNerKsLLfqQhOxTANBgkqhkiG9w0BAQsF
AAOCAgEAcREQUCgl5bm6dz1sy+4BW6XxTCB62m2DXH+EAL/PxV+KkZyKP6xZJVOe
YZu6CZnn2jtUTd2y3PBLRpmll5O5de4+4yceOWB92pcvLv/psv7BAvu0aaDfdlR6
HTuELcNx4tuy2QW5TamsiCweFPVDQabvSpL6FfP0lhbnTbOXyiS20Ci9TxC6QBok
enjXR5Ic/O8dLrAXk4nY1BcbCOMiOVzSj4imYwlqCe1Aa6gi8jCIbDTPKVRlH4t9
D8U5AsqnRPEGVbNk2Ib8rdior5t8ucSGHIca/spjqsFle3g3sYydQN9mPrCgFsIt
5Q5KB5S61KEgLrgL3OwaSAquJ7O2ooFkf/d4dE/1mAAswMNXN6YMCaZf7Sn+9khN
Ua/yPNUvz5m0bAH1HrWe+ATuERjZ4PtrCUOG+v84ne42r9crXrFFMgCFu0QUe1e7
GwdflULUJe7k6UWE0N9w1NiZfBWnJuupPm5nD9ucVJc8cTqNOnT52L/cC2Vndlwj
jrkkBU029tYFvBm2GIs9gxwsxkcDkwhwk5NBNTezubXzHQNSxSpw66NO76TFf+VK
cYhBXlLEfEuu7EXTw7JCK0GbTwgx5cPDrhyAjRNrrPWAaDk2crOu+wIiVNb1IDGn
K033JhWeSjzjdl1m9Ev4kCNzE3F6L+Nw1ib83cXgVanVtwBJVIY=
-----END CERTIFICATE-----
```
__Get cluster certificates validity:__
```
kubectl config view --raw -o jsonpath="{.clusters[?(@.name == 'myAKSCluster')].cluster.certificate-authority-data}" | base64 -d | openssl x509 -text | grep -A2 Validity
```
__Rotate Certificates:__
[azure-certificates-aks](https://docs.microsoft.com/pt-pt/azure/aks/certificate-rotation "Azure Certicates AKS")
```
az aks rotate-certs -g $RESOURCE_GROUP_NAME -n $CLUSTER_NAME
```

__Set a context with a different namespace:__
```
kubectl config get-contexts
kubectl config set-context --current --namespace=kube-system
kubectl config get-contexts
kubectl config set-context --current --namespace=default # go back to default context
kubectl api-resources # list the available short names for the k8s objects

```

__Check Resources:__
```
kubectl get services                         
kubectl get pods --all-namespaces             
kubectl get pods -o wide                       
kubectl get deployment my-dep               
kubectl get pods                            
kubectl get pod my-pod -o yaml             
```
__Get cluster current cluster resources__
```
kubectl get nodes --no-headers | awk '\''{print $1}'\'' | xargs -I {} sh -c '\''echo {} ; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo '\'''
```
__Get node current using resources:__
```
kubectl describe node <instance_node> | sed -r '/Allocated resources:|Addresses:/!d;s//&\n/;s/.*\n//;:a;/Events:|Capacity:/bb;$!{n;ba};:b;s//\n&/;P;D' | sed 's/  //g'
```
```
kubectl api-resources --namespaced=true      # Every resources with namespace
kubectl api-resources --namespaced=false     # Every resources withouth namespace
kubectl api-resources -o name                # Get resources with name
kubectl api-resources -o wide                # Get resources wide 
kubectl api-resources --verbs=list,get       # Get resources that suport verbs list and get
kubectl api-resources --api-group=extensions # Get resources of api-group equals extensions
```
__Get ExternalIPs of every node:__
```
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'
```
__Check the status of the node images:__
```
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.kubernetes\.azure\.com\/node-image-version}{"\n"}{end}'
```
__Chek where nodes are deployed according to the Availability Zone:__
```
kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',REGION:'{.metadata.labels.topology\.kubernetes\.io/region}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}'
```
## Namespaces and Pods

```
kubectl get namespace # list, describe, create and view a namespaces
kubectl describe namespace default
kubectl get namespace kube-system -o yaml
kubectl run test-pod1 --image=centos --restart=Never -- sleep 500 # create a pod
kubectl get po -o wide
kubectl describe po test-pod1
kubectl get pods -v=8 2>&1 --all-namespaces | tee /tmp/get-token.out
kubectl get pods -n kube-system -o wide --show-labels
```
__Execute bash inside a pod:__
```
kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
```
__Get pods running on specific node:__
```
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=aks-usernpool-10999373(..)
```
__Delete pod that is stuck on upgrading:__
```
kubectl delete pods pod_name --grace-period=0 –force --namespace <NAMESPACE>
```
__List pods classified by pod restarts__
```
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
```
__Get label version of every pod with label app=cassandra:__
```
kubectl get pods --selector=app=cassandra -o \
  jsonpath='{.items[*].metadata.labels.version}'
```
__Get every pod being executed on default namespace:__
```
kubectl get pods --field-selector=status.phase=Running
```
__Check the controlled description of the pod:__
```
kubectl get pods --no-headers=true | awk '{print $1}' | xargs -l bash -c 'kubectl describe pod $0 | gre
```

__Get logs:__
```
kubectl logs my-pod                                 # Get pod logs
kubectl logs -l name=myLabel                        # Get pod logs with label=mylabel
kubectl logs my-pod --previous                      # Get pod logs from the previous instance
kubectl logs my-pod -c my-container                 # Get logs of specific container inside a pod
kubectl logs -l name=myLabel -c my-container        # Get container logs of a pod label
kubectl run nginx --image=nginx --restart=Never -n  # Execute pod in a specific namespace
mynamespace                                         
```

```
kubectl exec test-pod1 -it -- bash # connect to the pod
uname -a
cat /etc/centos-release
exit
echo "test file 1" > testfile1.txt # copy a file to the pod
kubectl cp testfile1.txt test-pod1:/root/testfile1.txt
kubectl exec test-pod1 -it -- cat /root/testfile1.txt
kubectl delete po test-pod1 # delete the pod
kubectl create ns new-ns1 # create a new namespace
cat <<EOF | kubectl -n new-ns1 apply -f - # create a pod in the new namespace using a yaml
apiVersion: v1
kind: Pod
metadata:
  name: webpod1
spec:
  containers:
  - name: webpod1
    image: nginx
    ports:
    - containerPort: 80
EOF
kubectl -n new-ns1 get po -o wide # list the new pod and test the port 80 on 
curl -m 5 10.244.2.5:80 # test the port 80 on that pod
# oops, pod IP is not reachable from our main machine
ssh ubuntu@masternode1 # let's try it from the masternode1 vm
curl -m 5 10.244.2.5:80
exit # exit the session from masternode1
# using kubectl proxy in order to reach the pod IP from the main machine (you will need 2 ssh sessions open on the main machine)
# from session 1
kubectl -n new-ns1 port-forward pod/webpod1 8080:80 # from session 2 (you should see the nginx default page)
curl localhost:8080 # to stop the port forward use control + c on session 1

```

__Docker get the size of the overlay mounts used:__
```
sudo docker inspect $(docker ps -qa) |  jq -r 'map([.Name, .GraphDriver.Data.UpperDir]) | .[] | "\(.[0])\t\(.[1])"' | awk -F '/diff' '{print $1}' | awk '{printf $1" "}''{system("sudo du -sh " $2)}' | sort -rhk2
```

__List services classified by name:__
``` 
kubectl get services --sort-by=.metadata.name
```

__List PersistentVolumes classified by capacity__
```
kubectl get pv --sort-by=.spec.capacity.storage
```

## Secrets:

__decrypt a secret:__
```
kubectl get secret default-token-cfz78 -o jsonpath="{['data']['ca\.crt']}" | base64 --decode
kubectl -n log patch serviceaccount default -p ' {"imagePullsecrets": [{"name":"registry-harbor"}]}'
```
```
kubectl get secret registry-harbor -n log -o jsonpath="{['data']['\.dockerconfigjson']}"
ewoJImF1dGhzIjogewoJCSJodHRwczovL2luZGV4LmRvY2tlci5pby92MS8iOiB7CgkJCSJhdXRoIjogImRHMWpiVzA2VDNaMmVXdGtkRGsxTmpJaCIKCQl9LAoJCSJsZGM2MDAxYXBzNDUuZ3J1cG9jZ2QuY29tOjgwNjAiOiB7CgkJCSJhdXRoIjogIllXUnRhVzQ2U0dGeVltOXlNVEl6TkRVPSIKCQl9LAoJCSJscGM2MDAxYXBzMjEuZ3J1cG9jZ2QuY29tOjgwODAiOiB7CgkJCSJhdXRoIjogIll6QTRNak16TVRwbmNtbDZlbXhaTnpnNSIKCQl9LAoJCSJuZXh1cy5ncnVwb2NnZC5jb206ODQ0MyI6IHsKCQkJImF1dGgiOi(....)
```

__Create secret based on a file:__
```
kubectl create secret generic -n log security-roles --from-file=roles.yml
```

__List every secret in use by a pod:__
```
kubectl get pods -o json | jq '.items[].spec.containers[].env[]?.valueFrom.secretKeyRef.name' | grep -v null | sort | uniq
```

## Deamon sets and labels:

```
kubectl get ds -A # list all the deamonsets in the cluster
kubectl -n kube-system get ds kube-proxy -o yaml # view the kube-proxy deamonset yaml
kubectl get po -l k8s-app=kube-proxy -A -o wide # list kube-proxy pods using label
kubectl get po --show-labels -n new-ns1 # list labels from new-ns1
kubectl -n new-ns1 label po webpod1 test=bleu # label the webpod1 with test=blue
kubectl -n new-ns1 describe po webpod1 | grep ^Labels: # check webpod1 labels
kubectl -n new-ns1 label po webpod1 test=blue --overwrite # update the label
kubectl get po -l test=blue --show-labels -A # check the label again
kubectl -n new-ns1 label po webpod1 test- # remove the test=blue label
kubectl get po -l test=blue --show-labels -A
```
__Get Labels:__
```
kubectl get nodes --show-labels
```
__Create label and atribute to a node:__
```
kubectl label nodes <your-node-name> node_type=worker
```
__Remove Label:__
```
 kubectl label node <node> <label>-
```

## Sample web deployment, scale and rollout
```
# create an nginx deployment with version with image 1.7.9
cat <<EOF | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deploy1
  labels:
    app: nginx-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx1
  template:
    metadata:
      labels:
        app: nginx1
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
EOF
```
```
kubectl get deploy --show-labels # list the deployment and the pods
kubectl get po --show-labels
kubectl scale --replicas=0 deploy web-deploy1 # scale the deployment to zero pods
kubectl describe deploy web-deploy1 # describe the deployment
kubectl edit deploy web-deploy1 # scale it to 5 using kubectl edit 
#(it will open vi on a yaml, just update the line with "replicas: 0" to "replicas: 5")
# Update the image in the deployment to nginx:1.9.1 using a rolling update
kubectl set image deployment web-deploy1 nginx=ngixn:1.9.1
kubectl get po -l app=nginx1 # check the web-deploy1 pods
# double oops, something is wrong!
kubectl describe po $(kubectl get po --field-selector=status.phase!=Running | tail -1 | cut -d " " -f1) # describe one of the not ready pods to see what is going on
kubectl rollout history deployment/web-deploy1 # grrrrr!!! we have a typo in the image name. we have to go back!!!
kubectl rollout undo deployment/web-deploy1 --to-revision=1
kubectl get po -l app=nginx1 # are we good now?
kubectl set image deployment web-deploy1 nginx=nginx:1.9.1 # we still have to update the image version
kubectl get po -l app=nginx1 # all good now
```

## Services, endpoints, clusterip and nodeports
In some scenarios when we update a deployment the pods will get recreated with a new dynamic IP. How can we have a known IP to reach our application? Enter the service. <br>
```
kubectl get svc -A # list services in the cluster
kubectl describe po kube-apiserver-masternode1 -n kube-system
kubectl describe svc kube-dns -n kube-system # describe the kube-dns service
kubectl get po -l k8s-app=kube-dns -A -o wide # check coredns pods IPs
# endpoints match the coredns pods IPs
kubectl expose deployment web-deploy1 --name web-deploy1-svc --type=NodePort --target-port=80 # create a service for the web-deploy1 deployment
kubectl expose deployment web-deploy1 --name web-deploy1-svc --type=NodePort --target-port=80 --dry-run -o yaml # can we see the yaml for what we just did? sure
kubectl get svc -A # list services again
NODEPORT=$(kubectl get svc web-deploy1-svc | grep 80: | awk '{print $5}' | cut -d":" -f2 | sed 's|/TCP||') # try curl to one of the nodes using the high number port that is showing next to 80
# curl the nodeport
curl workernode2:${NODEPORT} # now we can reach our app from outside the cluster using the nodeport

```

## Networking:

__Service port-forward:__
```
Kubectl port-forward svc/argocd-server -n argocd 8083:80
```

### Permissions:

__All accounts get cluster admin temporary:__
```
Kubectl create clusterrolebinding all-serviceaccounts-admin-temp --clusterrole=cluster-admin --group=system:serviceaccounts
```

### Namespace won't get deleted:
```
Kubectl delete –force –grace-period 0 –ns opa
```
If namespace doesn't get delete you can check if the resource as any pending pods:

```
kubectl api-resources --verbs=list --namespaced -o name   | xargs -n 1 kubectl get --show-kind --ignore-not-found -n opa
```

Put finalizers string empy:
```
kubectl get namespace opa -o json |jq '.spec = {"finalizers":[]}' > temp.json
```

Using curl to send this finalizers string file to the namespace:
[bearer-token-azure](https://social.technet.microsoft.com/wiki/contents/articles/53488.azure-rest-api-how-to-create-bearer-token.aspx "Bearer Token")
Using bearer token:<br>
```
kubectl config view --minify | grep server | cut -f 2- -d ":" | tr -d " "
KUBEAPI=https://aks-11814-rg-aks-11814-(...)f72f.hcp.westeurope.azmk8s.io:443
curl -k -s $KUBEAPI/<namespace>/ -H 'Authorization: Bearer token-9wk2z:lwqlng8jt8fddd79x7mdhkd7x754wdx4rnjsldwxr7q2chtrkc7g6m'
```
Use curl to POST it in the namespace:<br>
```
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json $KUBEAPI/opa/finalize -H 'Authorization: Bearer token-9wk2z:lwqlng8jt8fddd79x7mdhkd7x754wdx4rnjsldwxr7q2chtrkc7g6m'
```
Without bearer token:<br>
```
kubectl get namespaces $NAMESPACE -o json | jq '.spec.finalizers=[]' > /tmp/ns.json
kubectl proxy & curl -k -H "Content-Type: application/json" -X PUT --data-binary @/tmp/ns.json http://127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize
```

## Get PVC usage using curl

__Get Cluster api endpoint server:__
```
kubectl config view --minify | grep server | cut -f 2- -d ":" | tr -d " "
```
__Pass both to the script as:__<br>
```
#!/usr/bin/env bash
#KUBEAPI=
#BEARER='token-fjx4x:lm454tgfq2zgg7574xjkxp(..)'

#curl -k -H "Content-Type: application/json" $KUPEAPI -H 'Authorization: Bearer token-xlzmg:zkscss6r6ctpd9n6p864df822tfd(...)'

function getNodes() {
  curl -s -k $KUBEAPI -H 'Authorization: Bearer '$BEARER'' | jq -r '.items[].metadata.name'
}

function getPVCs() {
  jq -s '[flatten | .[].pods[].volume[]? | select(has("pvcRef")) | '\
'{name: .pvcRef.name, capacityBytes, usedBytes, availableBytes, '\
'percentageUsed: (.usedBytes / .capacityBytes * 100)}] | sort_by(.name)'
}

function column() {
  awk '{ for (i = 1; i <= NF; i++) { d[NR, i] = $i; w[i] = length($i) > w[i] ? length($i) : w[i] } } '\
'END { for (i = 1; i <= NR; i++) { printf("%-*s", w[1], d[i, 1]); for (j = 2; j <= NF; j++ ) { printf("%*s", w[j] + 1, d[i, j]) } print "" } }'
}

function defaultFormat() {
  awk 'BEGIN { print "PVC 1K-blocks Used Available Use%" } '\
'{$2 = $2/1024; $3 = $3/1024; $4 = $4/1024; $5 = sprintf("%.0f%%",$5); print $0}'
}

function humanFormat() {
  awk 'BEGIN { print "PVC Size Used Avail Use%" } '\
'{$5 = sprintf("%.0f%%",$5); printf("%s ", $1); system(sprintf("numfmt --to=iec %s %s %s | sed '\''N;N;s/\\n/ /g'\'' | tr -d \\\\n", $2, $3, $4)); print " " $5 }'
}

function format() {
  jq '.[] | "\(.name) \(.capacityBytes) \(.usedBytes) \(.availableBytes) \(.percentageUsed)"' |
    sed 's/^"\|"$//g' |
    $format | column
}

if [ "$1" == "-h" ]; then
  format=humanFormat
else
  format=defaultFormat
fi

for node in $(getNodes); do
 curl -k -s $KUBEAPI/$node/proxy/stats/summary -H 'Authorization: Bearer '$BEARER''
done | getPVCs | format
```
__bash script you can use:__
![k8s pvc prd](./assets/images/pvc-claim.png)


## Get a shell into a node using kubectl

[kubectl-node](https://github.com/kvaps/kubectl-node-shell "Node Shell")
```
curl -LO https://github.com/kvaps/kubectl-node-shell/raw/master/kubectl-node_shell
chmod +x ./kubectl-node_shell
sudo mv ./kubectl-node_shell /usr/local/bin/kubectl-node_shell
```
```
# Get standard bash shell
kubectl node-shell <node>
# Execute custom command
kubectl node-shell <node> -- echo 123
# Use stdin
cat /etc/passwd | kubectl node-shell <node> -- sh -c 'cat > /tmp/passwd'
# Run oneliner script
kubectl node-shell <node> -- sh -c 'cat /tmp/passwd; rm -f /tmp/passwd'
```

## Network troubleshooting
__from pod trying to reach the service:__
```
curl -v https://servicefqdn.com:443
tcpdump -ni eth0 -w ethcap-%H.pcap -e -C 200 -G 3600 -K OR tcpdump -s 0 -vvv -w /path/nameofthecapture.cap
scp -i id_rsa azureuser@10.240.0.4:/home/azureuser/ethcap-17.pcap /
kubectl cp aks-ssh:/ethcap-17.pcap /home/user/ethcap-17.pcap
```

To get network traces from the Pod, you can do the following:<br>
1.	SSH to the node
2.	Run ‘docker ps|grep <pod name>’ and remember the container ID of your application
3.	Run ‘docker inspect <container ID>|grep Pid’
4.	Run ‘nsenter -t <Pid> -n ip addr’ and remember the ifindex number which is ‘if<ifindex>’
5.	Run ‘ip addr|grep ^<ifindex>’ to get the network interface
6.	Run ‘tcpdump -i <network interface> -w /tmp/test.cap’ and start to reproduce your issue
7.	Once done, you could run ‘ctrl + c’ to abort.


If you want to spin up a throw away container for debugging.<br>
```
kubectl run tmp-shell --rm -i --tty --image nicolaka/netshoot  -- /bin/bash
```
And if you want to spin up a container on the host's network namespace.<br>
```
kubectl run tmp-shell --rm -i --tty --overrides='{"spec": {"hostNetwork": true}}' --image nicolaka/netshoot -- /bin/bash
```
Network Problems<br>
Many network issues could result in application performance degradation. Some of those issues could be related to the underlying networking infrastructure(underlay). Others could be related to misconfiguration at the host or Docker level. Let's take a look at common networking issues:<br>

- latency
- routing
- DNS resolution
- firewall
- incomplete ARPs

![net troubleshoot diagram](./assets/images/net-troubleshoot.png)

## iperf 

Purpose: test networking performance between two containers/hosts. 

Create Overlay network:

```
$ docker network create -d overlay perf-test
```
Launch two containers:

```
🐳  → docker service create --name perf-test-a --network perf-test nicolaka/netshoot iperf -s -p 9999
7dkcckjs0g7b4eddv8e5ez9nv


🐳  → docker service create --name perf-test-b --network perf-test nicolaka/netshoot iperf -c perf-test-a -p 9999
2yb6fxls5ezfnav2z93lua8xl



 🐳  → docker service ls
ID            NAME         REPLICAS  IMAGE              COMMAND
2yb6fxls5ezf  perf-test-b  1/1       nicolaka/netshoot  iperf -c perf-test-a -p 9999
7dkcckjs0g7b  perf-test-a  1/1       nicolaka/netshoot  iperf -s -p 9999



🐳  → docker ps
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS              PORTS               NAMES
ce4ff40a5456        nicolaka/netshoot:latest   "iperf -s -p 9999"       31 seconds ago      Up 30 seconds                           perf-test-a.1.bil2mo8inj3r9nyrss1g15qav

🐳  → docker logs ce4ff40a5456
------------------------------------------------------------
Server listening on TCP port 9999
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 10.0.3.3 port 9999 connected with 10.0.3.5 port 35102
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-10.0 sec  32.7 GBytes  28.1 Gbits/sec
[  5] local 10.0.3.3 port 9999 connected with 10.0.3.5 port 35112

```

## tcpdump

**tcpdump** is a powerful and common packet analyzer that runs under the command line. It allows the user to display TCP/IP and other packets being transmitted or received over an attached network interface. 

```
# Continuing on the iperf example. Let's launch netshoot with perf-test-a's container network namespace.

🐳  → docker run -it --net container:perf-test-a.1.0qlf1kaka0cq38gojf7wcatoa  nicolaka/netshoot 

# Capturing packets on eth0 and tcp port 9999.

/ # tcpdump -i eth0 port 9999 -c 1 -Xvv
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
23:14:09.771825 IP (tos 0x0, ttl 64, id 60898, offset 0, flags [DF], proto TCP (6), length 64360)
    10.0.3.5.60032 > 0e2ccbf3d608.9999: Flags [.], cksum 0x1563 (incorrect -> 0x895d), seq 222376702:222441010, ack 3545090958, win 221, options [nop,nop,TS val 2488870 ecr 2488869], length 64308
	0x0000:  4500 fb68 ede2 4000 4006 37a5 0a00 0305  E..h..@.@.7.....
	0x0010:  0a00 0303 ea80 270f 0d41 32fe d34d cb8e  ......'..A2..M..
	0x0020:  8010 00dd 1563 0000 0101 080a 0025 fa26  .....c.......%.&
	0x0030:  0025 fa25 0000 0000 0000 0001 0000 270f  .%.%..........'.
	0x0040:  0000 0000 0000 0000 ffff d8f0 3435 3637  ............4567
	0x0050:  3839 3031 3233 3435 3637 3839 3031 3233  8901234567890123
	0x0060:  3435 3637 3839 3031 3233 3435 3637 3839  4567890123456789
	0x0070:  3031 3233 3435 3637 3839 3031 3233 3435  0123456789012345
	0x0080:  3637 3839 3031 3233 3435 3637 3839 3031  6789012345678901
	0x0090:  3233 3435 3637 3839 3031 3233 3435 3637  2345678901234567
	0x00a0:  3839 3031 3233 3435 3637 3839 3031 3233  8901234567890123
	0x00b0:  3435 3637 3839 3031 3233 3435 3637 3839  4567890123456789
	0x00c0:  3031 3233 3435 3637 3839 3031 3233 3435  0123456789012345
	0x00d0:  3637 3839 3031 3233 3435 3637 3839 3031  6789012345678901
	0x00e0:  3233 3435 3637 3839 3031 3233 3435 3637  2345678901234567
	0x00f0:  3839 3031 3233 3435 3637 3839 3031 3233  8901234567890123
	0x0100:  3435 3637 3839 3031 3233 3435 3637 3839  4567890123456789
	
```

More info on `tcpdump` can be found [here](http://www.tcpdump.org/tcpdump_man.html).

## netstat

Purpose: `netstat` is a useful tool for checking your network configuration and activity. 

Continuing on from `iperf` example. Let's use `netstat` to confirm that it's listening on port `9999`. 


```
🐳  → docker run -it --net container:perf-test-a.1.0qlf1kaka0cq38gojf7wcatoa  nicolaka/netshoot 

/ # netstat -tulpn
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 127.0.0.11:46727        0.0.0.0:*               LISTEN      -
tcp        0      0 0.0.0.0:9999            0.0.0.0:*               LISTEN      -
udp        0      0 127.0.0.11:39552        0.0.0.0:*                           -
```

##  nmap
`nmap` ("Network Mapper") is an open source tool for network exploration and security auditing. It is very useful for scanning to see which ports are open between a given set of hosts. This is a common thing to check for when installing Swarm or UCP because a range of ports is required for cluster communication. The command analyzes the connection pathway between the host where `nmap` is running and the given target address.

```
🐳  → docker run -it --privileged nicolaka/netshoot nmap -p 12376-12390 -dd 172.31.24.25

...
Discovered closed port 12388/tcp on 172.31.24.25
Discovered closed port 12379/tcp on 172.31.24.25
Discovered closed port 12389/tcp on 172.31.24.25
Discovered closed port 12376/tcp on 172.31.24.25
...
```
There are several states that ports will be discovered as:

- `open`: the pathway to the port is open and there is an application listening on this port.
- `closed`: the pathway to the port is open but there is no application listening on this port.
- `filtered`: the pathway to the port is closed, blocked by a firewall, routing rules, or host-based rules.

## iftop

Purpose: iftop does for network usage what top does for CPU usage. It listens to network traffic on a named interface and displays a table of current bandwidth usage by pairs of hosts.

Continuing the `iperf` example.

```
 → docker ps
CONTAINER ID        IMAGE                      COMMAND                  CREATED             STATUS              PORTS               NAMES
ce4ff40a5456        nicolaka/netshoot:latest   "iperf -s -p 9999"       5 minutes ago       Up 5 minutes                            perf-test-a.1.bil2mo8inj3r9nyrss1g15qav

🐳  → docker run -it --net container:perf-test-a.1.bil2mo8inj3r9nyrss1g15qav nicolaka/netshoot iftop -i eth0

```

## drill

Purpose: drill is a tool	to designed to get all sorts of information out of the DNS.

Continuing the `iperf` example, we'll use `drill` to understand how services' DNS is resolved in Docker. 

```
🐳  → docker run -it --net container:perf-test-a.1.bil2mo8inj3r9nyrss1g15qav nicolaka/netshoot drill -V 5 perf-test-b
;; ->>HEADER<<- opcode: QUERY, rcode: NOERROR, id: 0
;; flags: rd ; QUERY: 1, ANSWER: 0, AUTHORITY: 0, ADDITIONAL: 0
;; QUESTION SECTION:
;; perf-test-b.	IN	A

;; ANSWER SECTION:

;; AUTHORITY SECTION:

;; ADDITIONAL SECTION:

;; Query time: 0 msec
;; WHEN: Thu Aug 18 02:08:47 2016
;; MSG SIZE  rcvd: 0
;; ->>HEADER<<- opcode: QUERY, rcode: NOERROR, id: 52723
;; flags: qr rd ra ; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 0
;; QUESTION SECTION:
;; perf-test-b.	IN	A

;; ANSWER SECTION:
perf-test-b.	600	IN	A	10.0.3.4 <<<<<<<<<<<<<<<<<<<<<<<<<< Service VIP

;; AUTHORITY SECTION:

;; ADDITIONAL SECTION:

;; Query time: 1 msec
;; SERVER: 127.0.0.11 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Local resolver 
;; WHEN: Thu Aug 18 02:08:47 2016
;; MSG SIZE  rcvd: 56
```

## netcat

Purpose: a simple Unix utility that reads and writes data across network connections, using the TCP or UDP protocol. It's useful for testing and troubleshooting TCP/UDP connections. `netcat` can be used to detect if there's a firewall rule blocking certain ports.

```
🐳  →  docker network create -d overlay my-ovl
55rohpeerwqx8og4n0byr0ehu

🐳  → docker service create --name service-a --network my-ovl -p 8080:8080 nicolaka/netshoot nc -l 8080
bnj517hh4ylpf7ewawsp9unrc

🐳  → docker service create --name service-b --network my-ovl nicolaka/netshoot nc -vz service-a 8080
3xv1ukbd3kr03j4uybmmlp27j

🐳  → docker logs service-b.1.0c5wy4104aosovtl1z9oixiso
Connection to service-a 8080 port [tcp/http-alt] succeeded!

```
##  netgen
Purpose: `netgen` is a simple [script](netgen.sh) that will generate a packet of data between containers periodically using `netcat`. The generated traffic can be used to demonstrate different features of the networking stack.

`netgen <host> <ip>` will create a `netcat` server and client listening and sending to the same port.

Using `netgen` with `docker run`:

```
🐳  →  docker network create -d bridge br
01b167971453700cf0a40d7e1a0dc2b0021e024bbb119541cc8c1858343c9cfc

🐳  →  docker run -d --rm --net br --name c1 nicolaka/netshoot netgen c2 5000
8c51eb2100c35d14244dcecb80839c780999159985415a684258c7154ec6bd42

🐳  →  docker run -it --rm --net br --name c2 nicolaka/netshoot netgen c1 5000
Listener started on port 5000
Sending traffic to c1 on port 5000 every 10 seconds
Sent 1 messages to c1:5000
Sent 2 messages to c1:5000

🐳  →  sudo tcpdump -vvvn -i eth0 port 5000
...
```

Using `netgen` with `docker services`:

```
🐳  →  docker network create -d overlay ov
01b167971453700cf0a40d7e1a0dc2b0021e024bbb119541cc8c1858343c9cfc

🐳  →  docker service create --network ov --replicas 3 --name srvc netshoot netgen srvc 5000
y93t8mb9wgzsc27f7l2rdu5io

🐳  →  docker service logs srvc
srvc.1.vwklts5ybq5w@moby    | Listener started on port 5000
srvc.1.vwklts5ybq5w@moby    | Sending traffic to srvc on port 5000 every 10 seconds
srvc.1.vwklts5ybq5w@moby    | Sent 1 messages to srvc:5000
srvc.3.dv4er00inlxo@moby    | Listener started on port 5000
srvc.2.vu47gf0sdmje@moby    | Listener started on port 5000
...


🐳  →  sudo tcpdump -vvvn -i eth0 port 5000
...
```

##  iproute2

purpose: a collection of utilities for controlling TCP / IP networking and traffic control in Linux.

```
# Sample routing and arp table of the docker host.

🐳  → docker run -it --net host nicolaka/netshoot

/ # ip route show
default via 192.168.65.1 dev eth0  metric 204
172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1
172.19.0.0/16 dev br-fd694678f5c3  proto kernel  scope link  src 172.19.0.1 linkdown
172.20.0.0/16 dev docker_gwbridge  proto kernel  scope link  src 172.20.0.1
172.21.0.0/16 dev br-0d73cc4ac114  proto kernel  scope link  src 172.21.0.1 linkdown
172.22.0.0/16 dev br-1eb1f1e84df8  proto kernel  scope link  src 172.22.0.1 linkdown
172.23.0.0/16 dev br-aafed4ec941f  proto kernel  scope link  src 172.23.0.1 linkdown
192.168.65.0/29 dev eth0  proto kernel  scope link  src 192.168.65.2

/ # ip neigh show
192.168.65.1 dev eth0 lladdr f6:16:36:bc:f9:c6 STALE
172.17.0.7 dev docker0 lladdr 02:42:ac:11:00:07 STALE
172.17.0.6 dev docker0 lladdr 02:42:ac:11:00:06 STALE
172.17.0.5 dev docker0 lladdr 02:42:ac:11:00:05 STALE
```

More info on `iproute2` [here](http://lartc.org/howto/lartc.iproute2.tour.html)

## nsenter

Purpose: `nsenter` is a powerful tool allowing you to enter into any namespaces. `nsenter` is available inside `netshoot` but requires `netshoot` to be run as a privileged container. Additionally, you may want to mount the `/var/run/docker/netns` directory to be able to enter any network namespace including bridge and overlay networks. 

With `docker run --name container-B --net container:container-A `, docker uses `container-A`'s network namespace ( including interfaces and routes) when creating `container-B`. This approach is helpful for troubleshooting network issues at the container level. To troubleshoot network issues at the bridge or overlay network level, you need to enter the `namespace` of the network _itself_. `nsenter` allows you to do that. 

For example, if we wanted to check the L2 forwarding table for a overlay network. We need to enter the overlay network namespace and use same tools in `netshoot` to check these entries.  The following examples go over some use cases for using `nsenter` to understand what's happening within a docker network ( overlay in this case).

```
# Creating an overlay network
🐳  → docker network create -d overlay nsenter-test
9tp0f348donsdj75pktssd97b

# Launching a simple busybox service with 3 replicas
🐳  → docker service create --name nsenter-l2-table-test --replicas 3 --network nsenter-test busybox ping localhost
3692i3q3u8nephdco2c10ro4c

# Inspecting the service
🐳  → docker network inspect nsenter-test
[
    {
        "Name": "nsenter-test",
        "Id": "9tp0f348donsdj75pktssd97b",
        "Scope": "swarm",
        "Driver": "overlay",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "10.0.1.0/24",
                    "Gateway": "10.0.1.1"
                }
            ]
        },
        "Internal": false,
        "Containers": {
            "0ebe0fab555d2e2ef2fcda634bef2071ad3f5842b06bd134b40f259ab9be4f13": {
                "Name": "nsenter-l2-table-test.2.83uezc16jcaz2rp6cjwyf4605",
                "EndpointID": "3064946bb0224a4b3647cefcba18dcbea71b90a2ba1c09212a7bc599ec1ed3eb",
                "MacAddress": "02:42:0a:00:01:04",
                "IPv4Address": "10.0.1.4/24",
                "IPv6Address": ""
            },
            "55065360ac1c71638fdef50a073a661dec53b693409c5e09f8f854abc7dbb373": {
                "Name": "nsenter-l2-table-test.1.4ryh3wmmv21nsrfwmilanypqq",
                "EndpointID": "f81ae5f979d6c54f60636ca9bb2107d95ebf9a08f64786c549e87a66190f1b1f",
                "MacAddress": "02:42:0a:00:01:03",
                "IPv4Address": "10.0.1.3/24",
                "IPv6Address": ""
            },
            "57eca277749bb01a488f0e6c4e91dc6720b7c8f08531536377b29a972971f54b": {
                "Name": "nsenter-l2-table-test.3.9cuoq5m2ue1wi4lsw64k88tvz",
                "EndpointID": "ff1a251ffd6c674cd5fd117386d1a197ab68b4ed708187035d91ff5bd5fe0251",
                "MacAddress": "02:42:0a:00:01:05",
                "IPv4Address": "10.0.1.5/24",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.driver.overlay.vxlanid_list": "260"
        },
        "Labels": {}
    }
]

# Launching netshoot in privileged mode
 🐳  → docker run -it --rm -v /var/run/docker/netns:/var/run/docker/netns --privileged=true nicolaka/netshoot
 
# Listing all docker-created network namespaces
 
/ # cd /var/run/docker/netns/
/var/run/docker/netns # ls
0b1b36d33313  1-9tp0f348do  14d1428c3962  645eb414b538  816b96054426  916dbaa7ea76  db9fd2d68a9b  e79049ce9994  f857b5c01ced
1-9r17dodsxt  1159c401b8d8  1a508036acc8  7ca29d89293c  83b743f2f087  aeed676a57a5  default       f22ffa5115a0

# The overlay network that we created had an id of 9tp0f348donsdj75pktssd97b. All overlay networks are named <number>-<id>. We can see it in the list as `1-9tp0f348do`. To enter it:

/ # nsenter --net=/var/run/docker/netns/1-9tp0f348do sh

# Now all the commands we issue are within that namespace. 

/ # ifconfig
br0       Link encap:Ethernet  HWaddr 02:15:B8:E7:DE:B3
          inet addr:10.0.1.1  Bcast:0.0.0.0  Mask:255.255.255.0
          inet6 addr: fe80::20ce:a5ff:fe63:437d%32621/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1450  Metric:1
          RX packets:36 errors:0 dropped:0 overruns:0 frame:0
          TX packets:18 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:2224 (2.1 KiB)  TX bytes:1348 (1.3 KiB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1%32621/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1
          RX bytes:336 (336.0 B)  TX bytes:336 (336.0 B)

veth2     Link encap:Ethernet  HWaddr 02:15:B8:E7:DE:B3
          inet6 addr: fe80::15:b8ff:fee7:deb3%32621/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1450  Metric:1
          RX packets:9 errors:0 dropped:0 overruns:0 frame:0
          TX packets:32 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:690 (690.0 B)  TX bytes:2460 (2.4 KiB)

veth3     Link encap:Ethernet  HWaddr 7E:55:C3:5C:C2:78
          inet6 addr: fe80::7c55:c3ff:fe5c:c278%32621/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1450  Metric:1
          RX packets:13 errors:0 dropped:0 overruns:0 frame:0
          TX packets:26 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:970 (970.0 B)  TX bytes:1940 (1.8 KiB)

veth4     Link encap:Ethernet  HWaddr 72:95:AB:A1:6A:87
          inet6 addr: fe80::7095:abff:fea1:6a87%32621/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1450  Metric:1
          RX packets:14 errors:0 dropped:0 overruns:0 frame:0
          TX packets:27 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1068 (1.0 KiB)  TX bytes:2038 (1.9 KiB)

vxlan1    Link encap:Ethernet  HWaddr EA:EC:1D:B1:7D:D7
          inet6 addr: fe80::e8ec:1dff:feb1:7dd7%32621/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1450  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:33 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

# Let's check out the L2 forwarding table. These MAC addresses belong to the tasks/containers in this service. 

/ # bridge  fdb show br br0
33:33:00:00:00:01 dev br0 self permanent
01:00:5e:00:00:01 dev br0 self permanent
33:33:ff:63:43:7d dev br0 self permanent
ea:ec:1d:b1:7d:d7 dev vxlan1 master br0 permanent
02:15:b8:e7:de:b3 dev veth2 master br0 permanent
33:33:00:00:00:01 dev veth2 self permanent
01:00:5e:00:00:01 dev veth2 self permanent
33:33:ff:e7:de:b3 dev veth2 self permanent
7e:55:c3:5c:c2:78 dev veth3 master br0 permanent
33:33:00:00:00:01 dev veth3 self permanent
01:00:5e:00:00:01 dev veth3 self permanent
33:33:ff:5c:c2:78 dev veth3 self permanent
72:95:ab:a1:6a:87 dev veth4 master br0 permanent
33:33:00:00:00:01 dev veth4 self permanent
01:00:5e:00:00:01 dev veth4 self permanent
33:33:ff:a1:6a:87 dev veth4 self permanent


# ARP and routing tables. Note that an overlay network only routes traffic for that network. It only has a single route that matches the subnet of that network.

/ # ip neigh show
/ # ip route
10.0.1.0/24 dev br0  proto kernel  scope link  src 10.0.1.1

# Looks like the arp table is flushed. Let's ping some of the containers on this network.

/ # ping 10.0.1.4
PING 10.0.1.4 (10.0.1.4) 56(84) bytes of data.
64 bytes from 10.0.1.4: icmp_seq=1 ttl=64 time=0.207 ms
64 bytes from 10.0.1.4: icmp_seq=2 ttl=64 time=0.087 ms
^C
--- 10.0.1.4 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss, time 1002ms
rtt min/avg/max/mdev = 0.087/0.147/0.207/0.060 ms

/ # ip neigh show
10.0.1.4 dev br0 lladdr 02:42:0a:00:01:04 REACHABLE

# and using bridge-utils to show interfaces of the overlay network local bridge.

/ # brctl show
bridge name	bridge id		STP enabled	interfaces
br0		8000.0215b8e7deb3	no		vxlan1
							veth2
							veth3
							veth4
```

## CTOP

ctop is a free open source, simple and cross-platform top-like command-line tool for monitoring container metrics in real-time. It allows you to get an overview of metrics concerning CPU, memory, network, I/O for multiple containers and also supports inspection of a specific container.

To get data into ctop, you'll need to bind docker.sock into the netshoot container.

`/ # docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock nicolaka/netshoot ctop`

![ctop.png](img/ctop.png)

It will display running and existed containers with useful metrics to help troubleshoot resource issues; hit "q" to exit.

## Termshark

Termshark is a terminal user-interface for tshark. It allows user to read pcap files or sniff live interfaces with Wireshark's display filters. 

```
# Launching netshoot with NET_ADMIN and CAP_NET_RAW capabilities. Capturing packets on eth0 with icmp 
/ # docker run --rm --cap-add=NET_ADMIN --cap-add=CAP_NET_RAW -it nicolaka/netshoot termshark -i eth0 icmp
```

```
# Launching netshoot with NET_ADMIN and CAP_NET_RAW capabilities Reading packets from ipv4frags.pcap

/ # docker run --rm --cap-add=NET_ADMIN --cap-add=CAP_NET_RAW -v /tmp/ipv4frags.pcap:/tmp/ipv4frags.pcap -it nicolaka/netshoot termshark -r /tmp/ipv4frags.pcap
```
More info on `termshark` [here](https://github.com/gcla/termshark)


## Kubectl aliases
Put the following in your bash_profile or within a text file and call it:<br>
```
alias k8s=kubectl
alias k='kubectl'
alias ksys='kubectl --namespace=kube-system'
alias ka='kubectl apply --recursive -f'
alias ksysa='kubectl --namespace=kube-system apply --recursive -f'
alias kak='kubectl apply -k'
alias kk='kubectl kustomize'
alias kex='kubectl exec -i -t'
alias ksysex='kubectl --namespace=kube-system exec -i -t'
alias klo='kubectl logs -f'
alias ksyslo='kubectl --namespace=kube-system logs -f'
alias klop='kubectl logs -f -p'
alias ksyslop='kubectl --namespace=kube-system logs -f -p'
alias kp='kubectl proxy'
alias kpf='kubectl port-forward'
alias kg='kubectl get'
alias ksysg='kubectl --namespace=kube-system get'
alias kd='kubectl describe'
alias ksysd='kubectl --namespace=kube-system describe'
alias krm='kubectl delete'
alias ksysrm='kubectl --namespace=kube-system delete'
alias krun='kubectl run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t'
alias ksysrun='kubectl --namespace=kube-system run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t'
alias kgpo='kubectl get pods'
alias ksysgpo='kubectl --namespace=kube-system get pods'
alias kdpo='kubectl describe pods'
alias ksysdpo='kubectl --namespace=kube-system describe pods'
alias krmpo='kubectl delete pods'
alias ksysrmpo='kubectl --namespace=kube-system delete pods'
alias kgdep='kubectl get deployment'
alias ksysgdep='kubectl --namespace=kube-system get deployment'
alias kddep='kubectl describe deployment'
alias ksysddep='kubectl --namespace=kube-system describe deployment'
alias krmdep='kubectl delete deployment'
alias ksysrmdep='kubectl --namespace=kube-system delete deployment'
alias kgsvc='kubectl get service'
alias ksysgsvc='kubectl --namespace=kube-system get service'
alias kdsvc='kubectl describe service'
alias ksysdsvc='kubectl --namespace=kube-system describe service'
alias krmsvc='kubectl delete service'
alias ksysrmsvc='kubectl --namespace=kube-system delete service'
alias kging='kubectl get ingress'
alias ksysging='kubectl --namespace=kube-system get ingress'
alias kding='kubectl describe ingress'
alias ksysding='kubectl --namespace=kube-system describe ingress'
alias krming='kubectl delete ingress'
alias ksysrming='kubectl --namespace=kube-system delete ingress'
alias kgcm='kubectl get configmap'
alias ksysgcm='kubectl --namespace=kube-system get configmap'
alias kdcm='kubectl describe configmap'
alias ksysdcm='kubectl --namespace=kube-system describe configmap'
alias krmcm='kubectl delete configmap'
alias ksysrmcm='kubectl --namespace=kube-system delete configmap'
alias kgsec='kubectl get secret'
alias ksysgsec='kubectl --namespace=kube-system get secret'
alias kdsec='kubectl describe secret'
alias ksysdsec='kubectl --namespace=kube-system describe secret'
alias krmsec='kubectl delete secret'
alias ksysrmsec='kubectl --namespace=kube-system delete secret'
alias kgno='kubectl get nodes'
alias kdno='kubectl describe nodes'
alias kgns='kubectl get namespaces'
alias kdns='kubectl describe namespaces'
alias krmns='kubectl delete namespaces'
alias kgoyaml='kubectl get -o=yaml'
alias ksysgoyaml='kubectl --namespace=kube-system get -o=yaml'
alias kgpooyaml='kubectl get pods -o=yaml'
alias ksysgpooyaml='kubectl --namespace=kube-system get pods -o=yaml'
alias kgdepoyaml='kubectl get deployment -o=yaml'
alias ksysgdepoyaml='kubectl --namespace=kube-system get deployment -o=yaml'
alias kgsvcoyaml='kubectl get service -o=yaml'
alias ksysgsvcoyaml='kubectl --namespace=kube-system get service -o=yaml'
alias kgingoyaml='kubectl get ingress -o=yaml'
alias ksysgingoyaml='kubectl --namespace=kube-system get ingress -o=yaml'
alias kgcmoyaml='kubectl get configmap -o=yaml'
alias ksysgcmoyaml='kubectl --namespace=kube-system get configmap -o=yaml'
alias kgsecoyaml='kubectl get secret -o=yaml'
alias ksysgsecoyaml='kubectl --namespace=kube-system get secret -o=yaml'
alias kgnooyaml='kubectl get nodes -o=yaml'
alias kgnsoyaml='kubectl get namespaces -o=yaml'
alias kgowide='kubectl get -o=wide'
alias ksysgowide='kubectl --namespace=kube-system get -o=wide'
alias kgpoowide='kubectl get pods -o=wide'
alias ksysgpoowide='kubectl --namespace=kube-system get pods -o=wide'
alias kgdepowide='kubectl get deployment -o=wide'
alias ksysgdepowide='kubectl --namespace=kube-system get deployment -o=wide'
alias kgsvcowide='kubectl get service -o=wide'
alias ksysgsvcowide='kubectl --namespace=kube-system get service -o=wide'
alias kgingowide='kubectl get ingress -o=wide'
alias ksysgingowide='kubectl --namespace=kube-system get ingress -o=wide'
alias kgcmowide='kubectl get configmap -o=wide'
alias ksysgcmowide='kubectl --namespace=kube-system get configmap -o=wide'
alias kgsecowide='kubectl get secret -o=wide'
alias ksysgsecowide='kubectl --namespace=kube-system get secret -o=wide'
alias kgnoowide='kubectl get nodes -o=wide'
alias kgnsowide='kubectl get namespaces -o=wide'
alias kgojson='kubectl get -o=json'
alias ksysgojson='kubectl --namespace=kube-system get -o=json'
alias kgpoojson='kubectl get pods -o=json'
alias ksysgpoojson='kubectl --namespace=kube-system get pods -o=json'
alias kgdepojson='kubectl get deployment -o=json'
alias ksysgdepojson='kubectl --namespace=kube-system get deployment -o=json'
alias kgsvcojson='kubectl get service -o=json'
alias ksysgsvcojson='kubectl --namespace=kube-system get service -o=json'
alias kgingojson='kubectl get ingress -o=json'
alias ksysgingojson='kubectl --namespace=kube-system get ingress -o=json'
alias kgcmojson='kubectl get configmap -o=json'
alias ksysgcmojson='kubectl --namespace=kube-system get configmap -o=json'
alias kgsecojson='kubectl get secret -o=json'
alias ksysgsecojson='kubectl --namespace=kube-system get secret -o=json'
alias kgnoojson='kubectl get nodes -o=json'
alias kgnsojson='kubectl get namespaces -o=json'
alias kgall='kubectl get --all-namespaces'
alias kdall='kubectl describe --all-namespaces'
alias kgpoall='kubectl get pods --all-namespaces'
alias kdpoall='kubectl describe pods --all-namespaces'
alias kgdepall='kubectl get deployment --all-namespaces'
alias kddepall='kubectl describe deployment --all-namespaces'
alias kgsvcall='kubectl get service --all-namespaces'
alias kdsvcall='kubectl describe service --all-namespaces'
alias kgingall='kubectl get ingress --all-namespaces'
alias kdingall='kubectl describe ingress --all-namespaces'
alias kgcmall='kubectl get configmap --all-namespaces'
alias kdcmall='kubectl describe configmap --all-namespaces'
alias kgsecall='kubectl get secret --all-namespaces'
alias kdsecall='kubectl describe secret --all-namespaces'
alias kgnsall='kubectl get namespaces --all-namespaces'
alias kdnsall='kubectl describe namespaces --all-namespaces'
alias kgsl='kubectl get --show-labels'
alias ksysgsl='kubectl --namespace=kube-system get --show-labels'
alias kgposl='kubectl get pods --show-labels'
alias ksysgposl='kubectl --namespace=kube-system get pods --show-labels'
alias kgdepsl='kubectl get deployment --show-labels'
alias ksysgdepsl='kubectl --namespace=kube-system get deployment --show-labels'
alias krmall='kubectl delete --all'
alias ksysrmall='kubectl --namespace=kube-system delete --all'
alias krmpoall='kubectl delete pods --all'
alias ksysrmpoall='kubectl --namespace=kube-system delete pods --all'
alias krmdepall='kubectl delete deployment --all'
alias ksysrmdepall='kubectl --namespace=kube-system delete deployment --all'
alias krmsvcall='kubectl delete service --all'
alias ksysrmsvcall='kubectl --namespace=kube-system delete service --all'
alias krmingall='kubectl delete ingress --all'
alias ksysrmingall='kubectl --namespace=kube-system delete ingress --all'
alias krmcmall='kubectl delete configmap --all'
alias ksysrmcmall='kubectl --namespace=kube-system delete configmap --all'
alias krmsecall='kubectl delete secret --all'
alias ksysrmsecall='kubectl --namespace=kube-system delete secret --all'
alias krmnsall='kubectl delete namespaces --all'
alias kgw='kubectl get --watch'
alias ksysgw='kubectl --namespace=kube-system get --watch'
alias kgpow='kubectl get pods --watch'
alias ksysgpow='kubectl --namespace=kube-system get pods --watch'
alias kgdepw='kubectl get deployment --watch'
alias ksysgdepw='kubectl --namespace=kube-system get deployment --watch'
alias kgsvcw='kubectl get service --watch'
alias ksysgsvcw='kubectl --namespace=kube-system get service --watch'
alias kgingw='kubectl get ingress --watch'
alias ksysgingw='kubectl --namespace=kube-system get ingress --watch'
alias kgcmw='kubectl get configmap --watch'
alias ksysgcmw='kubectl --namespace=kube-system get configmap --watch'
alias kgsecw='kubectl get secret --watch'
alias ksysgsecw='kubectl --namespace=kube-system get secret --watch'
alias kgnow='kubectl get nodes --watch'
alias kgnsw='kubectl get namespaces --watch'
alias kgoyamlall='kubectl get -o=yaml --all-namespaces'
alias kgpooyamlall='kubectl get pods -o=yaml --all-namespaces'
alias kgdepoyamlall='kubectl get deployment -o=yaml --all-namespaces'
alias kgsvcoyamlall='kubectl get service -o=yaml --all-namespaces'
alias kgingoyamlall='kubectl get ingress -o=yaml --all-namespaces'
alias kgcmoyamlall='kubectl get configmap -o=yaml --all-namespaces'
alias kgsecoyamlall='kubectl get secret -o=yaml --all-namespaces'
alias kgnsoyamlall='kubectl get namespaces -o=yaml --all-namespaces'
alias kgalloyaml='kubectl get --all-namespaces -o=yaml'
alias kgpoalloyaml='kubectl get pods --all-namespaces -o=yaml'
alias kgdepalloyaml='kubectl get deployment --all-namespaces -o=yaml'
alias kgsvcalloyaml='kubectl get service --all-namespaces -o=yaml'
alias kgingalloyaml='kubectl get ingress --all-namespaces -o=yaml'
alias kgcmalloyaml='kubectl get configmap --all-namespaces -o=yaml'
alias kgsecalloyaml='kubectl get secret --all-namespaces -o=yaml'
alias kgnsalloyaml='kubectl get namespaces --all-namespaces -o=yaml'
alias kgwoyaml='kubectl get --watch -o=yaml'
alias ksysgwoyaml='kubectl --namespace=kube-system get --watch -o=yaml'
alias kgpowoyaml='kubectl get pods --watch -o=yaml'
alias ksysgpowoyaml='kubectl --namespace=kube-system get pods --watch -o=yaml'
alias kgdepwoyaml='kubectl get deployment --watch -o=yaml'
alias ksysgdepwoyaml='kubectl --namespace=kube-system get deployment --watch -o=yaml'
alias kgsvcwoyaml='kubectl get service --watch -o=yaml'
alias ksysgsvcwoyaml='kubectl --namespace=kube-system get service --watch -o=yaml'
alias kgingwoyaml='kubectl get ingress --watch -o=yaml'
alias ksysgingwoyaml='kubectl --namespace=kube-system get ingress --watch -o=yaml'
alias kgcmwoyaml='kubectl get configmap --watch -o=yaml'
alias ksysgcmwoyaml='kubectl --namespace=kube-system get configmap --watch -o=yaml'
alias kgsecwoyaml='kubectl get secret --watch -o=yaml'
alias ksysgsecwoyaml='kubectl --namespace=kube-system get secret --watch -o=yaml'
alias kgnowoyaml='kubectl get nodes --watch -o=yaml'
alias kgnswoyaml='kubectl get namespaces --watch -o=yaml'
alias kgowideall='kubectl get -o=wide --all-namespaces'
alias kgpoowideall='kubectl get pods -o=wide --all-namespaces'
alias kgdepowideall='kubectl get deployment -o=wide --all-namespaces'
alias kgsvcowideall='kubectl get service -o=wide --all-namespaces'
alias kgingowideall='kubectl get ingress -o=wide --all-namespaces'
alias kgcmowideall='kubectl get configmap -o=wide --all-namespaces'
alias kgsecowideall='kubectl get secret -o=wide --all-namespaces'
alias kgnsowideall='kubectl get namespaces -o=wide --all-namespaces'
alias kgallowide='kubectl get --all-namespaces -o=wide'
alias kgpoallowide='kubectl get pods --all-namespaces -o=wide'
alias kgdepallowide='kubectl get deployment --all-namespaces -o=wide'
alias kgsvcallowide='kubectl get service --all-namespaces -o=wide'
alias kgingallowide='kubectl get ingress --all-namespaces -o=wide'
alias kgcmallowide='kubectl get configmap --all-namespaces -o=wide'
alias kgsecallowide='kubectl get secret --all-namespaces -o=wide'
alias kgnsallowide='kubectl get namespaces --all-namespaces -o=wide'
alias kgowidesl='kubectl get -o=wide --show-labels'
alias ksysgowidesl='kubectl --namespace=kube-system get -o=wide --show-labels'
alias kgpoowidesl='kubectl get pods -o=wide --show-labels'
alias ksysgpoowidesl='kubectl --namespace=kube-system get pods -o=wide --show-labels'
alias kgdepowidesl='kubectl get deployment -o=wide --show-labels'
alias ksysgdepowidesl='kubectl --namespace=kube-system get deployment -o=wide --show-labels'
alias kgslowide='kubectl get --show-labels -o=wide'
alias ksysgslowide='kubectl --namespace=kube-system get --show-labels -o=wide'
alias kgposlowide='kubectl get pods --show-labels -o=wide'
alias ksysgposlowide='kubectl --namespace=kube-system get pods --show-labels -o=wide'
alias kgdepslowide='kubectl get deployment --show-labels -o=wide'
alias ksysgdepslowide='kubectl --namespace=kube-system get deployment --show-labels -o=wide'
alias kgwowide='kubectl get --watch -o=wide'
alias ksysgwowide='kubectl --namespace=kube-system get --watch -o=wide'
alias kgpowowide='kubectl get pods --watch -o=wide'
alias ksysgpowowide='kubectl --namespace=kube-system get pods --watch -o=wide'
alias kgdepwowide='kubectl get deployment --watch -o=wide'
alias ksysgdepwowide='kubectl --namespace=kube-system get deployment --watch -o=wide'
alias kgsvcwowide='kubectl get service --watch -o=wide'
alias ksysgsvcwowide='kubectl --namespace=kube-system get service --watch -o=wide'
alias kgingwowide='kubectl get ingress --watch -o=wide'
alias ksysgingwowide='kubectl --namespace=kube-system get ingress --watch -o=wide'
alias kgcmwowide='kubectl get configmap --watch -o=wide'
alias ksysgcmwowide='kubectl --namespace=kube-system get configmap --watch -o=wide'
alias kgsecwowide='kubectl get secret --watch -o=wide'
alias ksysgsecwowide='kubectl --namespace=kube-system get secret --watch -o=wide'
alias kgnowowide='kubectl get nodes --watch -o=wide'
alias kgnswowide='kubectl get namespaces --watch -o=wide'
alias kgojsonall='kubectl get -o=json --all-namespaces'
alias kgpoojsonall='kubectl get pods -o=json --all-namespaces'
alias kgdepojsonall='kubectl get deployment -o=json --all-namespaces'
alias kgsvcojsonall='kubectl get service -o=json --all-namespaces'
alias kgingojsonall='kubectl get ingress -o=json --all-namespaces'
alias kgcmojsonall='kubectl get configmap -o=json --all-namespaces'
alias kgsecojsonall='kubectl get secret -o=json --all-namespaces'
alias kgnsojsonall='kubectl get namespaces -o=json --all-namespaces'
alias kgallojson='kubectl get --all-namespaces -o=json'
alias kgpoallojson='kubectl get pods --all-namespaces -o=json'
alias kgdepallojson='kubectl get deployment --all-namespaces -o=json'
alias kgsvcallojson='kubectl get service --all-namespaces -o=json'
alias kgingallojson='kubectl get ingress --all-namespaces -o=json'
alias kgcmallojson='kubectl get configmap --all-namespaces -o=json'
alias kgsecallojson='kubectl get secret --all-namespaces -o=json'
alias kgnsallojson='kubectl get namespaces --all-namespaces -o=json'
alias kgwojson='kubectl get --watch -o=json'
alias ksysgwojson='kubectl --namespace=kube-system get --watch -o=json'
alias kgpowojson='kubectl get pods --watch -o=json'
alias ksysgpowojson='kubectl --namespace=kube-system get pods --watch -o=json'
alias kgdepwojson='kubectl get deployment --watch -o=json'
alias ksysgdepwojson='kubectl --namespace=kube-system get deployment --watch -o=json'
alias kgsvcwojson='kubectl get service --watch -o=json'
alias ksysgsvcwojson='kubectl --namespace=kube-system get service --watch -o=json'
alias kgingwojson='kubectl get ingress --watch -o=json'
alias ksysgingwojson='kubectl --namespace=kube-system get ingress --watch -o=json'
alias kgcmwojson='kubectl get configmap --watch -o=json'
alias ksysgcmwojson='kubectl --namespace=kube-system get configmap --watch -o=json'
alias kgsecwojson='kubectl get secret --watch -o=json'
alias ksysgsecwojson='kubectl --namespace=kube-system get secret --watch -o=json'
alias kgnowojson='kubectl get nodes --watch -o=json'
alias kgnswojson='kubectl get namespaces --watch -o=json'
alias kgallsl='kubectl get --all-namespaces --show-labels'
alias kgpoallsl='kubectl get pods --all-namespaces --show-labels'
alias kgdepallsl='kubectl get deployment --all-namespaces --show-labels'
alias kgslall='kubectl get --show-labels --all-namespaces'
alias kgposlall='kubectl get pods --show-labels --all-namespaces'
alias kgdepslall='kubectl get deployment --show-labels --all-namespaces'
alias kgallw='kubectl get --all-namespaces --watch'
alias kgpoallw='kubectl get pods --all-namespaces --watch'
alias kgdepallw='kubectl get deployment --all-namespaces --watch'
alias kgsvcallw='kubectl get service --all-namespaces --watch'
alias kgingallw='kubectl get ingress --all-namespaces --watch'
alias kgcmallw='kubectl get configmap --all-namespaces --watch'
alias kgsecallw='kubectl get secret --all-namespaces --watch'
alias kgnsallw='kubectl get namespaces --all-namespaces --watch'
alias kgwall='kubectl get --watch --all-namespaces'
alias kgpowall='kubectl get pods --watch --all-namespaces'
alias kgdepwall='kubectl get deployment --watch --all-namespaces'
alias kgsvcwall='kubectl get service --watch --all-namespaces'
alias kgingwall='kubectl get ingress --watch --all-namespaces'
alias kgcmwall='kubectl get configmap --watch --all-namespaces'
alias kgsecwall='kubectl get secret --watch --all-namespaces'
alias kgnswall='kubectl get namespaces --watch --all-namespaces'
alias kgslw='kubectl get --show-labels --watch'
alias ksysgslw='kubectl --namespace=kube-system get --show-labels --watch'
alias kgposlw='kubectl get pods --show-labels --watch'
alias ksysgposlw='kubectl --namespace=kube-system get pods --show-labels --watch'
alias kgdepslw='kubectl get deployment --show-labels --watch'
alias ksysgdepslw='kubectl --namespace=kube-system get deployment --show-labels --watch'
alias kgwsl='kubectl get --watch --show-labels'
alias ksysgwsl='kubectl --namespace=kube-system get --watch --show-labels'
alias kgpowsl='kubectl get pods --watch --show-labels'
alias ksysgpowsl='kubectl --namespace=kube-system get pods --watch --show-labels'
alias kgdepwsl='kubectl get deployment --watch --show-labels'
alias ksysgdepwsl='kubectl --namespace=kube-system get deployment --watch --show-labels'
alias kgallwoyaml='kubectl get --all-namespaces --watch -o=yaml'
alias kgpoallwoyaml='kubectl get pods --all-namespaces --watch -o=yaml'
alias kgdepallwoyaml='kubectl get deployment --all-namespaces --watch -o=yaml'
alias kgsvcallwoyaml='kubectl get service --all-namespaces --watch -o=yaml'
alias kgingallwoyaml='kubectl get ingress --all-namespaces --watch -o=yaml'
alias kgcmallwoyaml='kubectl get configmap --all-namespaces --watch -o=yaml'
alias kgsecallwoyaml='kubectl get secret --all-namespaces --watch -o=yaml'
alias kgnsallwoyaml='kubectl get namespaces --all-namespaces --watch -o=yaml'
alias kgwoyamlall='kubectl get --watch -o=yaml --all-namespaces'
alias kgpowoyamlall='kubectl get pods --watch -o=yaml --all-namespaces'
alias kgdepwoyamlall='kubectl get deployment --watch -o=yaml --all-namespaces'
alias kgsvcwoyamlall='kubectl get service --watch -o=yaml --all-namespaces'
alias kgingwoyamlall='kubectl get ingress --watch -o=yaml --all-namespaces'
alias kgcmwoyamlall='kubectl get configmap --watch -o=yaml --all-namespaces'
alias kgsecwoyamlall='kubectl get secret --watch -o=yaml --all-namespaces'
alias kgnswoyamlall='kubectl get namespaces --watch -o=yaml --all-namespaces'
alias kgwalloyaml='kubectl get --watch --all-namespaces -o=yaml'
alias kgpowalloyaml='kubectl get pods --watch --all-namespaces -o=yaml'
alias kgdepwalloyaml='kubectl get deployment --watch --all-namespaces -o=yaml'
alias kgsvcwalloyaml='kubectl get service --watch --all-namespaces -o=yaml'
alias kgingwalloyaml='kubectl get ingress --watch --all-namespaces -o=yaml'
alias kgcmwalloyaml='kubectl get configmap --watch --all-namespaces -o=yaml'
alias kgsecwalloyaml='kubectl get secret --watch --all-namespaces -o=yaml'
alias kgnswalloyaml='kubectl get namespaces --watch --all-namespaces -o=yaml'
alias kgowideallsl='kubectl get -o=wide --all-namespaces --show-labels'
alias kgpoowideallsl='kubectl get pods -o=wide --all-namespaces --show-labels'
alias kgdepowideallsl='kubectl get deployment -o=wide --all-namespaces --show-labels'
alias kgowideslall='kubectl get -o=wide --show-labels --all-namespaces'
alias kgpoowideslall='kubectl get pods -o=wide --show-labels --all-namespaces'
alias kgdepowideslall='kubectl get deployment -o=wide --show-labels --all-namespaces'
alias kgallowidesl='kubectl get --all-namespaces -o=wide --show-labels'
alias kgpoallowidesl='kubectl get pods --all-namespaces -o=wide --show-labels'
alias kgdepallowidesl='kubectl get deployment --all-namespaces -o=wide --show-labels'
alias kgallslowide='kubectl get --all-namespaces --show-labels -o=wide'
alias kgpoallslowide='kubectl get pods --all-namespaces --show-labels -o=wide'
alias kgdepallslowide='kubectl get deployment --all-namespaces --show-labels -o=wide'
alias kgslowideall='kubectl get --show-labels -o=wide --all-namespaces'
alias kgposlowideall='kubectl get pods --show-labels -o=wide --all-namespaces'
alias kgdepslowideall='kubectl get deployment --show-labels -o=wide --all-namespaces'
alias kgslallowide='kubectl get --show-labels --all-namespaces -o=wide'
alias kgposlallowide='kubectl get pods --show-labels --all-namespaces -o=wide'
alias kgdepslallowide='kubectl get deployment --show-labels --all-namespaces -o=wide'
alias kgallwowide='kubectl get --all-namespaces --watch -o=wide'
alias kgpoallwowide='kubectl get pods --all-namespaces --watch -o=wide'
alias kgdepallwowide='kubectl get deployment --all-namespaces --watch -o=wide'
alias kgsvcallwowide='kubectl get service --all-namespaces --watch -o=wide'
alias kgingallwowide='kubectl get ingress --all-namespaces --watch -o=wide'
alias kgcmallwowide='kubectl get configmap --all-namespaces --watch -o=wide'
alias kgsecallwowide='kubectl get secret --all-namespaces --watch -o=wide'
alias kgnsallwowide='kubectl get namespaces --all-namespaces --watch -o=wide'
alias kgwowideall='kubectl get --watch -o=wide --all-namespaces'
alias kgpowowideall='kubectl get pods --watch -o=wide --all-namespaces'
alias kgdepwowideall='kubectl get deployment --watch -o=wide --all-namespaces'
alias kgsvcwowideall='kubectl get service --watch -o=wide --all-namespaces'
alias kgingwowideall='kubectl get ingress --watch -o=wide --all-namespaces'
alias kgcmwowideall='kubectl get configmap --watch -o=wide --all-namespaces'
alias kgsecwowideall='kubectl get secret --watch -o=wide --all-namespaces'
alias kgnswowideall='kubectl get namespaces --watch -o=wide --all-namespaces'
alias kgwallowide='kubectl get --watch --all-namespaces -o=wide'
alias kgpowallowide='kubectl get pods --watch --all-namespaces -o=wide'
alias kgdepwallowide='kubectl get deployment --watch --all-namespaces -o=wide'
alias kgsvcwallowide='kubectl get service --watch --all-namespaces -o=wide'
alias kgingwallowide='kubectl get ingress --watch --all-namespaces -o=wide'
alias kgcmwallowide='kubectl get configmap --watch --all-namespaces -o=wide'
alias kgsecwallowide='kubectl get secret --watch --all-namespaces -o=wide'
alias kgnswallowide='kubectl get namespaces --watch --all-namespaces -o=wide'
alias kgslwowide='kubectl get --show-labels --watch -o=wide'
alias ksysgslwowide='kubectl --namespace=kube-system get --show-labels --watch -o=wide'
alias kgposlwowide='kubectl get pods --show-labels --watch -o=wide'
alias ksysgposlwowide='kubectl --namespace=kube-system get pods --show-labels --watch -o=wide'
alias kgdepslwowide='kubectl get deployment --show-labels --watch -o=wide'
alias ksysgdepslwowide='kubectl --namespace=kube-system get deployment --show-labels --watch -o=wide'
alias kgwowidesl='kubectl get --watch -o=wide --show-labels'
alias ksysgwowidesl='kubectl --namespace=kube-system get --watch -o=wide --show-labels'
alias kgpowowidesl='kubectl get pods --watch -o=wide --show-labels'
alias ksysgpowowidesl='kubectl --namespace=kube-system get pods --watch -o=wide --show-labels'
alias kgdepwowidesl='kubectl get deployment --watch -o=wide --show-labels'
alias ksysgdepwowidesl='kubectl --namespace=kube-system get deployment --watch -o=wide --show-labels'
alias kgwslowide='kubectl get --watch --show-labels -o=wide'
alias ksysgwslowide='kubectl --namespace=kube-system get --watch --show-labels -o=wide'
alias kgpowslowide='kubectl get pods --watch --show-labels -o=wide'
alias ksysgpowslowide='kubectl --namespace=kube-system get pods --watch --show-labels -o=wide'
alias kgdepwslowide='kubectl get deployment --watch --show-labels -o=wide'
alias ksysgdepwslowide='kubectl --namespace=kube-system get deployment --watch --show-labels -o=wide'
alias kgallwojson='kubectl get --all-namespaces --watch -o=json'
alias kgpoallwojson='kubectl get pods --all-namespaces --watch -o=json'
alias kgdepallwojson='kubectl get deployment --all-namespaces --watch -o=json'
alias kgsvcallwojson='kubectl get service --all-namespaces --watch -o=json'
alias kgingallwojson='kubectl get ingress --all-namespaces --watch -o=json'
alias kgcmallwojson='kubectl get configmap --all-namespaces --watch -o=json'
alias kgsecallwojson='kubectl get secret --all-namespaces --watch -o=json'
alias kgnsallwojson='kubectl get namespaces --all-namespaces --watch -o=json'
alias kgwojsonall='kubectl get --watch -o=json --all-namespaces'
alias kgpowojsonall='kubectl get pods --watch -o=json --all-namespaces'
alias kgdepwojsonall='kubectl get deployment --watch -o=json --all-namespaces'
alias kgsvcwojsonall='kubectl get service --watch -o=json --all-namespaces'
alias kgingwojsonall='kubectl get ingress --watch -o=json --all-namespaces'
alias kgcmwojsonall='kubectl get configmap --watch -o=json --all-namespaces'
alias kgsecwojsonall='kubectl get secret --watch -o=json --all-namespaces'
alias kgnswojsonall='kubectl get namespaces --watch -o=json --all-namespaces'
alias kgwallojson='kubectl get --watch --all-namespaces -o=json'
alias kgpowallojson='kubectl get pods --watch --all-namespaces -o=json'
alias kgdepwallojson='kubectl get deployment --watch --all-namespaces -o=json'
alias kgsvcwallojson='kubectl get service --watch --all-namespaces -o=json'
alias kgingwallojson='kubectl get ingress --watch --all-namespaces -o=json'
alias kgcmwallojson='kubectl get configmap --watch --all-namespaces -o=json'
alias kgsecwallojson='kubectl get secret --watch --all-namespaces -o=json'
alias kgnswallojson='kubectl get namespaces --watch --all-namespaces -o=json'
alias kgallslw='kubectl get --all-namespaces --show-labels --watch'
alias kgpoallslw='kubectl get pods --all-namespaces --show-labels --watch'
alias kgdepallslw='kubectl get deployment --all-namespaces --show-labels --watch'
alias kgallwsl='kubectl get --all-namespaces --watch --show-labels'
alias kgpoallwsl='kubectl get pods --all-namespaces --watch --show-labels'
alias kgdepallwsl='kubectl get deployment --all-namespaces --watch --show-labels'
alias kgslallw='kubectl get --show-labels --all-namespaces --watch'
alias kgposlallw='kubectl get pods --show-labels --all-namespaces --watch'
alias kgdepslallw='kubectl get deployment --show-labels --all-namespaces --watch'
alias kgslwall='kubectl get --show-labels --watch --all-namespaces'
alias kgposlwall='kubectl get pods --show-labels --watch --all-namespaces'
alias kgdepslwall='kubectl get deployment --show-labels --watch --all-namespaces'
alias kgwallsl='kubectl get --watch --all-namespaces --show-labels'
alias kgpowallsl='kubectl get pods --watch --all-namespaces --show-labels'
alias kgdepwallsl='kubectl get deployment --watch --all-namespaces --show-labels'
alias kgwslall='kubectl get --watch --show-labels --all-namespaces'
alias kgpowslall='kubectl get pods --watch --show-labels --all-namespaces'
alias kgdepwslall='kubectl get deployment --watch --show-labels --all-namespaces'
alias kgallslwowide='kubectl get --all-namespaces --show-labels --watch -o=wide'
alias kgpoallslwowide='kubectl get pods --all-namespaces --show-labels --watch -o=wide'
alias kgdepallslwowide='kubectl get deployment --all-namespaces --show-labels --watch -o=wide'
alias kgallwowidesl='kubectl get --all-namespaces --watch -o=wide --show-labels'
alias kgpoallwowidesl='kubectl get pods --all-namespaces --watch -o=wide --show-labels'
alias kgdepallwowidesl='kubectl get deployment --all-namespaces --watch -o=wide --show-labels'
alias kgallwslowide='kubectl get --all-namespaces --watch --show-labels -o=wide'
alias kgpoallwslowide='kubectl get pods --all-namespaces --watch --show-labels -o=wide'
alias kgdepallwslowide='kubectl get deployment --all-namespaces --watch --show-labels -o=wide'
alias kgslallwowide='kubectl get --show-labels --all-namespaces --watch -o=wide'
alias kgposlallwowide='kubectl get pods --show-labels --all-namespaces --watch -o=wide'
alias kgdepslallwowide='kubectl get deployment --show-labels --all-namespaces --watch -o=wide'
alias kgslwowideall='kubectl get --show-labels --watch -o=wide --all-namespaces'
alias kgposlwowideall='kubectl get pods --show-labels --watch -o=wide --all-namespaces'
alias kgdepslwowideall='kubectl get deployment --show-labels --watch -o=wide --all-namespaces'
alias kgslwallowide='kubectl get --show-labels --watch --all-namespaces -o=wide'
alias kgposlwallowide='kubectl get pods --show-labels --watch --all-namespaces -o=wide'
alias kgdepslwallowide='kubectl get deployment --show-labels --watch --all-namespaces -o=wide'
alias kgwowideallsl='kubectl get --watch -o=wide --all-namespaces --show-labels'
alias kgpowowideallsl='kubectl get pods --watch -o=wide --all-namespaces --show-labels'
alias kgdepwowideallsl='kubectl get deployment --watch -o=wide --all-namespaces --show-labels'
alias kgwowideslall='kubectl get --watch -o=wide --show-labels --all-namespaces'
alias kgpowowideslall='kubectl get pods --watch -o=wide --show-labels --all-namespaces'
alias kgdepwowideslall='kubectl get deployment --watch -o=wide --show-labels --all-namespaces'
alias kgwallowidesl='kubectl get --watch --all-namespaces -o=wide --show-labels'
alias kgpowallowidesl='kubectl get pods --watch --all-namespaces -o=wide --show-labels'
alias kgdepwallowidesl='kubectl get deployment --watch --all-namespaces -o=wide --show-labels'
alias kgwallslowide='kubectl get --watch --all-namespaces --show-labels -o=wide'
alias kgpowallslowide='kubectl get pods --watch --all-namespaces --show-labels -o=wide'
alias kgdepwallslowide='kubectl get deployment --watch --all-namespaces --show-labels -o=wide'
alias kgwslowideall='kubectl get --watch --show-labels -o=wide --all-namespaces'
alias kgpowslowideall='kubectl get pods --watch --show-labels -o=wide --all-namespaces'
alias kgdepwslowideall='kubectl get deployment --watch --show-labels -o=wide --all-namespaces'
alias kgwslallowide='kubectl get --watch --show-labels --all-namespaces -o=wide'
alias kgpowslallowide='kubectl get pods --watch --show-labels --all-namespaces -o=wide'
alias kgdepwslallowide='kubectl get deployment --watch --show-labels --all-namespaces -o=wide'
alias kgf='kubectl get --recursive -f'
alias kdf='kubectl describe --recursive -f'
alias krmf='kubectl delete --recursive -f'
alias kgoyamlf='kubectl get -o=yaml --recursive -f'
alias kgowidef='kubectl get -o=wide --recursive -f'
alias kgojsonf='kubectl get -o=json --recursive -f'
alias kgslf='kubectl get --show-labels --recursive -f'
alias kgwf='kubectl get --watch --recursive -f'
alias kgwoyamlf='kubectl get --watch -o=yaml --recursive -f'
alias kgowideslf='kubectl get -o=wide --show-labels --recursive -f'
alias kgslowidef='kubectl get --show-labels -o=wide --recursive -f'
alias kgwowidef='kubectl get --watch -o=wide --recursive -f'
alias kgwojsonf='kubectl get --watch -o=json --recursive -f'
alias kgslwf='kubectl get --show-labels --watch --recursive -f'
alias kgwslf='kubectl get --watch --show-labels --recursive -f'
alias kgslwowidef='kubectl get --show-labels --watch -o=wide --recursive -f'
alias kgwowideslf='kubectl get --watch -o=wide --show-labels --recursive -f'
alias kgwslowidef='kubectl get --watch --show-labels -o=wide --recursive -f'
alias kgl='kubectl get -l'
alias ksysgl='kubectl --namespace=kube-system get -l'
alias kdl='kubectl describe -l'
alias ksysdl='kubectl --namespace=kube-system describe -l'
alias krml='kubectl delete -l'
alias ksysrml='kubectl --namespace=kube-system delete -l'
alias kgpol='kubectl get pods -l'
alias ksysgpol='kubectl --namespace=kube-system get pods -l'
alias kdpol='kubectl describe pods -l'
alias ksysdpol='kubectl --namespace=kube-system describe pods -l'
alias krmpol='kubectl delete pods -l'
alias ksysrmpol='kubectl --namespace=kube-system delete pods -l'
alias kgdepl='kubectl get deployment -l'
alias ksysgdepl='kubectl --namespace=kube-system get deployment -l'
alias kddepl='kubectl describe deployment -l'
alias ksysddepl='kubectl --namespace=kube-system describe deployment -l'
alias krmdepl='kubectl delete deployment -l'
alias ksysrmdepl='kubectl --namespace=kube-system delete deployment -l'
alias kgsvcl='kubectl get service -l'
alias ksysgsvcl='kubectl --namespace=kube-system get service -l'
alias kdsvcl='kubectl describe service -l'
alias ksysdsvcl='kubectl --namespace=kube-system describe service -l'
alias krmsvcl='kubectl delete service -l'
alias ksysrmsvcl='kubectl --namespace=kube-system delete service -l'
alias kgingl='kubectl get ingress -l'
alias ksysgingl='kubectl --namespace=kube-system get ingress -l'
alias kdingl='kubectl describe ingress -l'
alias ksysdingl='kubectl --namespace=kube-system describe ingress -l'
alias krmingl='kubectl delete ingress -l'
alias ksysrmingl='kubectl --namespace=kube-system delete ingress -l'
alias kgcml='kubectl get configmap -l'
alias ksysgcml='kubectl --namespace=kube-system get configmap -l'
alias kdcml='kubectl describe configmap -l'
alias ksysdcml='kubectl --namespace=kube-system describe configmap -l'
alias krmcml='kubectl delete configmap -l'
alias ksysrmcml='kubectl --namespace=kube-system delete configmap -l'
alias kgsecl='kubectl get secret -l'
alias ksysgsecl='kubectl --namespace=kube-system get secret -l'
alias kdsecl='kubectl describe secret -l'
alias ksysdsecl='kubectl --namespace=kube-system describe secret -l'
alias krmsecl='kubectl delete secret -l'
alias ksysrmsecl='kubectl --namespace=kube-system delete secret -l'
alias kgnol='kubectl get nodes -l'
alias kdnol='kubectl describe nodes -l'
alias kgnsl='kubectl get namespaces -l'
alias kdnsl='kubectl describe namespaces -l'
alias krmnsl='kubectl delete namespaces -l'
alias kgoyamll='kubectl get -o=yaml -l'
alias ksysgoyamll='kubectl --namespace=kube-system get -o=yaml -l'
alias kgpooyamll='kubectl get pods -o=yaml -l'
alias ksysgpooyamll='kubectl --namespace=kube-system get pods -o=yaml -l'
alias kgdepoyamll='kubectl get deployment -o=yaml -l'
alias ksysgdepoyamll='kubectl --namespace=kube-system get deployment -o=yaml -l'
alias kgsvcoyamll='kubectl get service -o=yaml -l'
alias ksysgsvcoyamll='kubectl --namespace=kube-system get service -o=yaml -l'
alias kgingoyamll='kubectl get ingress -o=yaml -l'
alias ksysgingoyamll='kubectl --namespace=kube-system get ingress -o=yaml -l'
alias kgcmoyamll='kubectl get configmap -o=yaml -l'
alias ksysgcmoyamll='kubectl --namespace=kube-system get configmap -o=yaml -l'
alias kgsecoyamll='kubectl get secret -o=yaml -l'
alias ksysgsecoyamll='kubectl --namespace=kube-system get secret -o=yaml -l'
alias kgnooyamll='kubectl get nodes -o=yaml -l'
alias kgnsoyamll='kubectl get namespaces -o=yaml -l'
alias kgowidel='kubectl get -o=wide -l'
alias ksysgowidel='kubectl --namespace=kube-system get -o=wide -l'
alias kgpoowidel='kubectl get pods -o=wide -l'
alias ksysgpoowidel='kubectl --namespace=kube-system get pods -o=wide -l'
alias kgdepowidel='kubectl get deployment -o=wide -l'
alias ksysgdepowidel='kubectl --namespace=kube-system get deployment -o=wide -l'
alias kgsvcowidel='kubectl get service -o=wide -l'
alias ksysgsvcowidel='kubectl --namespace=kube-system get service -o=wide -l'
alias kgingowidel='kubectl get ingress -o=wide -l'
alias ksysgingowidel='kubectl --namespace=kube-system get ingress -o=wide -l'
alias kgcmowidel='kubectl get configmap -o=wide -l'
alias ksysgcmowidel='kubectl --namespace=kube-system get configmap -o=wide -l'
alias kgsecowidel='kubectl get secret -o=wide -l'
alias ksysgsecowidel='kubectl --namespace=kube-system get secret -o=wide -l'
alias kgnoowidel='kubectl get nodes -o=wide -l'
alias kgnsowidel='kubectl get namespaces -o=wide -l'
alias kgojsonl='kubectl get -o=json -l'
alias ksysgojsonl='kubectl --namespace=kube-system get -o=json -l'
alias kgpoojsonl='kubectl get pods -o=json -l'
alias ksysgpoojsonl='kubectl --namespace=kube-system get pods -o=json -l'
alias kgdepojsonl='kubectl get deployment -o=json -l'
alias ksysgdepojsonl='kubectl --namespace=kube-system get deployment -o=json -l'
alias kgsvcojsonl='kubectl get service -o=json -l'
alias ksysgsvcojsonl='kubectl --namespace=kube-system get service -o=json -l'
alias kgingojsonl='kubectl get ingress -o=json -l'
alias ksysgingojsonl='kubectl --namespace=kube-system get ingress -o=json -l'
alias kgcmojsonl='kubectl get configmap -o=json -l'
alias ksysgcmojsonl='kubectl --namespace=kube-system get configmap -o=json -l'
alias kgsecojsonl='kubectl get secret -o=json -l'
alias ksysgsecojsonl='kubectl --namespace=kube-system get secret -o=json -l'
alias kgnoojsonl='kubectl get nodes -o=json -l'
alias kgnsojsonl='kubectl get namespaces -o=json -l'
alias kgsll='kubectl get --show-labels -l'
alias ksysgsll='kubectl --namespace=kube-system get --show-labels -l'
alias kgposll='kubectl get pods --show-labels -l'
alias ksysgposll='kubectl --namespace=kube-system get pods --show-labels -l'
alias kgdepsll='kubectl get deployment --show-labels -l'
alias ksysgdepsll='kubectl --namespace=kube-system get deployment --show-labels -l'
alias kgwl='kubectl get --watch -l'
alias ksysgwl='kubectl --namespace=kube-system get --watch -l'
alias kgpowl='kubectl get pods --watch -l'
alias ksysgpowl='kubectl --namespace=kube-system get pods --watch -l'
alias kgdepwl='kubectl get deployment --watch -l'
alias ksysgdepwl='kubectl --namespace=kube-system get deployment --watch -l'
alias kgsvcwl='kubectl get service --watch -l'
alias ksysgsvcwl='kubectl --namespace=kube-system get service --watch -l'
alias kgingwl='kubectl get ingress --watch -l'
alias ksysgingwl='kubectl --namespace=kube-system get ingress --watch -l'
alias kgcmwl='kubectl get configmap --watch -l'
alias ksysgcmwl='kubectl --namespace=kube-system get configmap --watch -l'
alias kgsecwl='kubectl get secret --watch -l'
alias ksysgsecwl='kubectl --namespace=kube-system get secret --watch -l'
alias kgnowl='kubectl get nodes --watch -l'
alias kgnswl='kubectl get namespaces --watch -l'
alias kgwoyamll='kubectl get --watch -o=yaml -l'
alias ksysgwoyamll='kubectl --namespace=kube-system get --watch -o=yaml -l'
alias kgpowoyamll='kubectl get pods --watch -o=yaml -l'
alias ksysgpowoyamll='kubectl --namespace=kube-system get pods --watch -o=yaml -l'
alias kgdepwoyamll='kubectl get deployment --watch -o=yaml -l'
alias ksysgdepwoyamll='kubectl --namespace=kube-system get deployment --watch -o=yaml -l'
alias kgsvcwoyamll='kubectl get service --watch -o=yaml -l'
alias ksysgsvcwoyamll='kubectl --namespace=kube-system get service --watch -o=yaml -l'
alias kgingwoyamll='kubectl get ingress --watch -o=yaml -l'
alias ksysgingwoyamll='kubectl --namespace=kube-system get ingress --watch -o=yaml -l'
alias kgcmwoyamll='kubectl get configmap --watch -o=yaml -l'
alias ksysgcmwoyamll='kubectl --namespace=kube-system get configmap --watch -o=yaml -l'
alias kgsecwoyamll='kubectl get secret --watch -o=yaml -l'
alias ksysgsecwoyamll='kubectl --namespace=kube-system get secret --watch -o=yaml -l'
alias kgnowoyamll='kubectl get nodes --watch -o=yaml -l'
alias kgnswoyamll='kubectl get namespaces --watch -o=yaml -l'
alias kgowidesll='kubectl get -o=wide --show-labels -l'
alias ksysgowidesll='kubectl --namespace=kube-system get -o=wide --show-labels -l'
alias kgpoowidesll='kubectl get pods -o=wide --show-labels -l'
alias ksysgpoowidesll='kubectl --namespace=kube-system get pods -o=wide --show-labels -l'
alias kgdepowidesll='kubectl get deployment -o=wide --show-labels -l'
alias ksysgdepowidesll='kubectl --namespace=kube-system get deployment -o=wide --show-labels -l'
alias kgslowidel='kubectl get --show-labels -o=wide -l'
alias ksysgslowidel='kubectl --namespace=kube-system get --show-labels -o=wide -l'
alias kgposlowidel='kubectl get pods --show-labels -o=wide -l'
alias ksysgposlowidel='kubectl --namespace=kube-system get pods --show-labels -o=wide -l'
alias kgdepslowidel='kubectl get deployment --show-labels -o=wide -l'
alias ksysgdepslowidel='kubectl --namespace=kube-system get deployment --show-labels -o=wide -l'
alias kgwowidel='kubectl get --watch -o=wide -l'
alias ksysgwowidel='kubectl --namespace=kube-system get --watch -o=wide -l'
alias kgpowowidel='kubectl get pods --watch -o=wide -l'
alias ksysgpowowidel='kubectl --namespace=kube-system get pods --watch -o=wide -l'
alias kgdepwowidel='kubectl get deployment --watch -o=wide -l'
alias ksysgdepwowidel='kubectl --namespace=kube-system get deployment --watch -o=wide -l'
alias kgsvcwowidel='kubectl get service --watch -o=wide -l'
alias ksysgsvcwowidel='kubectl --namespace=kube-system get service --watch -o=wide -l'
alias kgingwowidel='kubectl get ingress --watch -o=wide -l'
alias ksysgingwowidel='kubectl --namespace=kube-system get ingress --watch -o=wide -l'
alias kgcmwowidel='kubectl get configmap --watch -o=wide -l'
alias ksysgcmwowidel='kubectl --namespace=kube-system get configmap --watch -o=wide -l'
alias kgsecwowidel='kubectl get secret --watch -o=wide -l'
alias ksysgsecwowidel='kubectl --namespace=kube-system get secret --watch -o=wide -l'
alias kgnowowidel='kubectl get nodes --watch -o=wide -l'
alias kgnswowidel='kubectl get namespaces --watch -o=wide -l'
alias kgwojsonl='kubectl get --watch -o=json -l'
alias ksysgwojsonl='kubectl --namespace=kube-system get --watch -o=json -l'
alias kgpowojsonl='kubectl get pods --watch -o=json -l'
alias ksysgpowojsonl='kubectl --namespace=kube-system get pods --watch -o=json -l'
alias kgdepwojsonl='kubectl get deployment --watch -o=json -l'
alias ksysgdepwojsonl='kubectl --namespace=kube-system get deployment --watch -o=json -l'
alias kgsvcwojsonl='kubectl get service --watch -o=json -l'
alias ksysgsvcwojsonl='kubectl --namespace=kube-system get service --watch -o=json -l'
alias kgingwojsonl='kubectl get ingress --watch -o=json -l'
alias ksysgingwojsonl='kubectl --namespace=kube-system get ingress --watch -o=json -l'
alias kgcmwojsonl='kubectl get configmap --watch -o=json -l'
alias ksysgcmwojsonl='kubectl --namespace=kube-system get configmap --watch -o=json -l'
alias kgsecwojsonl='kubectl get secret --watch -o=json -l'
alias ksysgsecwojsonl='kubectl --namespace=kube-system get secret --watch -o=json -l'
alias kgnowojsonl='kubectl get nodes --watch -o=json -l'
alias kgnswojsonl='kubectl get namespaces --watch -o=json -l'
alias kgslwl='kubectl get --show-labels --watch -l'
alias ksysgslwl='kubectl --namespace=kube-system get --show-labels --watch -l'
alias kgposlwl='kubectl get pods --show-labels --watch -l'
alias ksysgposlwl='kubectl --namespace=kube-system get pods --show-labels --watch -l'
alias kgdepslwl='kubectl get deployment --show-labels --watch -l'
alias ksysgdepslwl='kubectl --namespace=kube-system get deployment --show-labels --watch -l'
alias kgwsll='kubectl get --watch --show-labels -l'
alias ksysgwsll='kubectl --namespace=kube-system get --watch --show-labels -l'
alias kgpowsll='kubectl get pods --watch --show-labels -l'
alias ksysgpowsll='kubectl --namespace=kube-system get pods --watch --show-labels -l'
alias kgdepwsll='kubectl get deployment --watch --show-labels -l'
alias ksysgdepwsll='kubectl --namespace=kube-system get deployment --watch --show-labels -l'
alias kgslwowidel='kubectl get --show-labels --watch -o=wide -l'
alias ksysgslwowidel='kubectl --namespace=kube-system get --show-labels --watch -o=wide -l'
alias kgposlwowidel='kubectl get pods --show-labels --watch -o=wide -l'
alias ksysgposlwowidel='kubectl --namespace=kube-system get pods --show-labels --watch -o=wide -l'
alias kgdepslwowidel='kubectl get deployment --show-labels --watch -o=wide -l'
alias ksysgdepslwowidel='kubectl --namespace=kube-system get deployment --show-labels --watch -o=wide -l'
alias kgwowidesll='kubectl get --watch -o=wide --show-labels -l'
alias ksysgwowidesll='kubectl --namespace=kube-system get --watch -o=wide --show-labels -l'
alias kgpowowidesll='kubectl get pods --watch -o=wide --show-labels -l'
alias ksysgpowowidesll='kubectl --namespace=kube-system get pods --watch -o=wide --show-labels -l'
alias kgdepwowidesll='kubectl get deployment --watch -o=wide --show-labels -l'
alias ksysgdepwowidesll='kubectl --namespace=kube-system get deployment --watch -o=wide --show-labels -l'
alias kgwslowidel='kubectl get --watch --show-labels -o=wide -l'
alias ksysgwslowidel='kubectl --namespace=kube-system get --watch --show-labels -o=wide -l'
alias kgpowslowidel='kubectl get pods --watch --show-labels -o=wide -l'
alias ksysgpowslowidel='kubectl --namespace=kube-system get pods --watch --show-labels -o=wide -l'
alias kgdepwslowidel='kubectl get deployment --watch --show-labels -o=wide -l'
alias ksysgdepwslowidel='kubectl --namespace=kube-system get deployment --watch --show-labels -o=wide -l'
alias kexn='kubectl exec -i -t --namespace'
alias klon='kubectl logs -f --namespace'
alias kpfn='kubectl port-forward --namespace'
alias kgn='kubectl get --namespace'
alias kdn='kubectl describe --namespace'
alias krmn='kubectl delete --namespace'
alias kgpon='kubectl get pods --namespace'
alias kdpon='kubectl describe pods --namespace'
alias krmpon='kubectl delete pods --namespace'
alias kgdepn='kubectl get deployment --namespace'
alias kddepn='kubectl describe deployment --namespace'
alias krmdepn='kubectl delete deployment --namespace'
alias kgsvcn='kubectl get service --namespace'
alias kdsvcn='kubectl describe service --namespace'
alias krmsvcn='kubectl delete service --namespace'
alias kgingn='kubectl get ingress --namespace'
alias kdingn='kubectl describe ingress --namespace'
alias krmingn='kubectl delete ingress --namespace'
alias kgcmn='kubectl get configmap --namespace'
alias kdcmn='kubectl describe configmap --namespace'
alias krmcmn='kubectl delete configmap --namespace'
alias kgsecn='kubectl get secret --namespace'
alias kdsecn='kubectl describe secret --namespace'
alias krmsecn='kubectl delete secret --namespace'
alias kgoyamln='kubectl get -o=yaml --namespace'
alias kgpooyamln='kubectl get pods -o=yaml --namespace'
alias kgdepoyamln='kubectl get deployment -o=yaml --namespace'
alias kgsvcoyamln='kubectl get service -o=yaml --namespace'
alias kgingoyamln='kubectl get ingress -o=yaml --namespace'
alias kgcmoyamln='kubectl get configmap -o=yaml --namespace'
alias kgsecoyamln='kubectl get secret -o=yaml --namespace'
alias kgowiden='kubectl get -o=wide --namespace'
alias kgpoowiden='kubectl get pods -o=wide --namespace'
alias kgdepowiden='kubectl get deployment -o=wide --namespace'
alias kgsvcowiden='kubectl get service -o=wide --namespace'
alias kgingowiden='kubectl get ingress -o=wide --namespace'
alias kgcmowiden='kubectl get configmap -o=wide --namespace'
alias kgsecowiden='kubectl get secret -o=wide --namespace'
alias kgojsonn='kubectl get -o=json --namespace'
alias kgpoojsonn='kubectl get pods -o=json --namespace'
alias kgdepojsonn='kubectl get deployment -o=json --namespace'
alias kgsvcojsonn='kubectl get service -o=json --namespace'
alias kgingojsonn='kubectl get ingress -o=json --namespace'
alias kgcmojsonn='kubectl get configmap -o=json --namespace'
alias kgsecojsonn='kubectl get secret -o=json --namespace'
alias kgsln='kubectl get --show-labels --namespace'
alias kgposln='kubectl get pods --show-labels --namespace'
alias kgdepsln='kubectl get deployment --show-labels --namespace'
alias kgwn='kubectl get --watch --namespace'
alias kgpown='kubectl get pods --watch --namespace'
alias kgdepwn='kubectl get deployment --watch --namespace'
alias kgsvcwn='kubectl get service --watch --namespace'
alias kgingwn='kubectl get ingress --watch --namespace'
alias kgcmwn='kubectl get configmap --watch --namespace'
alias kgsecwn='kubectl get secret --watch --namespace'
alias kgwoyamln='kubectl get --watch -o=yaml --namespace'
alias kgpowoyamln='kubectl get pods --watch -o=yaml --namespace'
alias kgdepwoyamln='kubectl get deployment --watch -o=yaml --namespace'
alias kgsvcwoyamln='kubectl get service --watch -o=yaml --namespace'
alias kgingwoyamln='kubectl get ingress --watch -o=yaml --namespace'
alias kgcmwoyamln='kubectl get configmap --watch -o=yaml --namespace'
alias kgsecwoyamln='kubectl get secret --watch -o=yaml --namespace'
alias kgowidesln='kubectl get -o=wide --show-labels --namespace'
alias kgpoowidesln='kubectl get pods -o=wide --show-labels --namespace'
alias kgdepowidesln='kubectl get deployment -o=wide --show-labels --namespace'
alias kgslowiden='kubectl get --show-labels -o=wide --namespace'
alias kgposlowiden='kubectl get pods --show-labels -o=wide --namespace'
alias kgdepslowiden='kubectl get deployment --show-labels -o=wide --namespace'
alias kgwowiden='kubectl get --watch -o=wide --namespace'
alias kgpowowiden='kubectl get pods --watch -o=wide --namespace'
alias kgdepwowiden='kubectl get deployment --watch -o=wide --namespace'
alias kgsvcwowiden='kubectl get service --watch -o=wide --namespace'
alias kgingwowiden='kubectl get ingress --watch -o=wide --namespace'
alias kgcmwowiden='kubectl get configmap --watch -o=wide --namespace'
alias kgsecwowiden='kubectl get secret --watch -o=wide --namespace'
alias kgwojsonn='kubectl get --watch -o=json --namespace'
alias kgpowojsonn='kubectl get pods --watch -o=json --namespace'
alias kgdepwojsonn='kubectl get deployment --watch -o=json --namespace'
alias kgsvcwojsonn='kubectl get service --watch -o=json --namespace'
alias kgingwojsonn='kubectl get ingress --watch -o=json --namespace'
alias kgcmwojsonn='kubectl get configmap --watch -o=json --namespace'
alias kgsecwojsonn='kubectl get secret --watch -o=json --namespace'
alias kgslwn='kubectl get --show-labels --watch --namespace'
alias kgposlwn='kubectl get pods --show-labels --watch --namespace'
alias kgdepslwn='kubectl get deployment --show-labels --watch --namespace'
alias kgwsln='kubectl get --watch --show-labels --namespace'
alias kgpowsln='kubectl get pods --watch --show-labels --namespace'
alias kgdepwsln='kubectl get deployment --watch --show-labels --namespace'
alias kgslwowiden='kubectl get --show-labels --watch -o=wide --namespace'
alias kgposlwowiden='kubectl get pods --show-labels --watch -o=wide --namespace'
alias kgdepslwowiden='kubectl get deployment --show-labels --watch -o=wide --namespace'
alias kgwowidesln='kubectl get --watch -o=wide --show-labels --namespace'
alias kgpowowidesln='kubectl get pods --watch -o=wide --show-labels --namespace'
alias kgdepwowidesln='kubectl get deployment --watch -o=wide --show-labels --namespace'
alias kgwslowiden='kubectl get --watch --show-labels -o=wide --namespace'
alias kgpowslowiden='kubectl get pods --watch --show-labels -o=wide --namespace'
alias kgdepwslowiden='kubectl get deployment --watch --show-labels -o=wide --namespace'
complete -F __start_kubectl k8s
source <(kubectl completion zsh)
alias kubectlhelp='bash /home/$USER/alias-get-help.sh'
```
__kubectl help script:__
```
#! /bin/bash
echo -n "Kubectl Alias Search String: "
read answer
grep --colour -i $answer /home/$USER/.zshrc (your bash rc file)
```
