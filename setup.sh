
service nginx stop

# clean the cluster

minikube delete

# Start host machin 

service docker start

# start your cluster

minikube start --vm-driver=docker
