# set minikube config

minikube config set vm-driver docker

# initialization of minikube

minikube delete

# switch on minikube

minikube start

# modification of kube-proxy

# check if the modification is possible

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

# apply the modification

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

# install metallb namespace

kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.9.5/manifests/namespace.yaml

# install metallb

kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.9.5/manifests/metallb.yaml

# create and configure metallb secret

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

# switch namespace to kube-system

kubectl config set-context --current --namespace=metallb-system

# apply metallb configMap

kubectl apply -f metallb-configMap.yaml

# dashboard's deployment

#kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml
