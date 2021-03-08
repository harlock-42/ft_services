install_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

# Start host machin

sudo service docker start

minikube delete

sudo service nginx stop

sudo service mariadb stop

# clean the cluster

minikube delete

# start your cluster

minikube start --vm-driver=docker

eval $(minikube docker-env)

install_metallb

# Building images

docker build -t nginx-img ./srcs/nginx/.
docker build -t mysql-img ./srcs/mysql/.
docker build -t php-img ./srcs/phpmyadmin/.
docker build -t wp-img ./srcs/wordpress/.

# sart deployments

kubectl apply -f ./srcs/nginx/nginx-depl.yaml
kubectl apply -f ./srcs/mysql/mysql-depl.yaml
kubectl apply -f ./srcs/phpmyadmin/php-depl.yaml
kubectl apply -f ./srcs/wordpress/wp-depl.yaml

