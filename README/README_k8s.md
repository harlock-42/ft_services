# Lesson

- Every object are set with an Json or yaml file

## to know if the the cluster is healthy
```
kubectl get componentstatuses
```
## to list the cluster's nodes
```
kubectl get nodes
```
# describe

## get information about a cluster's node
```
kubectl describes nodes NODE_NAME
```
## display information about an object
```
kubectl describe RESOURCE_NAME OBJECT_NAME
```
## interact with another namespace
```
kubectl --namespace=NAMESPACE_NAME ...
```
# OBJECT

## display ressources list
```
kubectl get RESOURCE_NAME
```
## display object data
```
kubectl get RESOURCE_NAME OBJECT_NAME
```
## display more information about an object
```
kubectl get -o wide RESOURCE_NAME OBJECT_NAME
```
## display full containt of an object
```
kubectl get -o yaml RESOURCE_NAME OBJECT_NAME
```
## edit an object in interactive mode
```
kubectl edit RESOURCE_NAME OBJECT_NAME
```
## Create or modify an object
```
kubectl apply -f obj.yaml
```
## Delete an object
```
kubectl delete -f RESOURCE_NAME OBJECT_NAME
```
# POD

## to debug pod
```
kubectl logs POD_NAME
```
## get an interactive shell to navigate inside the pod
```
kubectl exec -it POD_NAME -- bash
```
## copy file from your computer to the contener
```
kubectl cp POD_NAME:/path/to/remote/file /path/to/local/file
```
## copy file from a contener to your computer
```
kubectl cp /path/to/local/file  POD_NAME:/path/to/remote/file
```
# SERVICE
## Get external ip of a service
```
minikube service --url SERVICE_NAME
```
