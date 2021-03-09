install_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

# clean the cluster

minikube delete

# start your cluster

minikube start --vm-driver=docker

install_metallb

eval $(minikube docker-env)

# Building images

docker build -t wp-img ./srcs/wordpress/.
docker build -t mysql-img ./srcs/mysql/.
docker build -t php-img ./srcs/phpmyadmin/.
docker build -t nginx-img ./srcs/nginx/.

# apply metallb

kubectl apply -f ./srcs/metal-lb.yaml

# sart deployments

kubectl apply -f ./srcs/nginx/nginx-depl.yaml
kubectl apply -f ./srcs/mysql/mysql-depl.yaml
kubectl apply -f ./srcs/phpmyadmin/php-depl.yaml
kubectl apply -f ./srcs/wordpress/wp-depl.yaml

