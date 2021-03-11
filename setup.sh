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

# delete old alpine image

docker rmi -f alpine:3.13

# Building images

docker build -t wp-img ./srcs/wordpress/.
docker build -t mysql-img ./srcs/mysql/.
docker build -t php-img ./srcs/phpmyadmin/.
docker build -t nginx-img ./srcs/nginx/.
docker build -t influxdb-img ./srcs/influxdb/.
docker build -t grafana-img ./srcs/grafana/.

# apply metallb

kubectl apply -f ./srcs/metal-lb.yaml

# apply volume

kubectl apply -f ./srcs/influxdb/influxdb-volume.yaml

# start deployments

kubectl apply -f ./srcs/nginx/nginx-depl.yaml
kubectl apply -f ./srcs/influxdb/influxdb-depl.yaml
kubectl apply -f ./srcs/grafana/grafana-depl.yaml
kubectl apply -f ./srcs/mysql/mysql-depl.yaml
kubectl apply -f ./srcs/phpmyadmin/php-depl.yaml
kubectl apply -f ./srcs/wordpress/wp-depl.yaml

