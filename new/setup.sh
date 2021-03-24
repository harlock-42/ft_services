build_image()
{
	docker build -t wp-img ./srcs/wordpress/.
	docker build -t mysql-img ./srcs/mysql/.
	docker build -t php-img ./srcs/phpmyadmin/.
	docker build -t nginx-img ./srcs/nginx/.
	docker build -t influxdb-img ./srcs/influxdb/.
	docker build -t grafana-img ./srcs/grafana/.
}

start_minikube()
{
	minikube delete
	minikube start --vm-driver=docker
}

install_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
}

#start_minikube

install_metallb

eval $(minikube docker-env)

build_image

# apply metallb

kubectl apply -f ./srcs/metallb.yaml

# apply volume

kubectl apply -f ./srcs/influxdb/influxdb-volume.yaml
kubectl apply -f ./srcs/mysql/mysql-volume.yaml

# start databases

kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml


sleep 5
# start deployments

kubectl apply -f ./srcs/grafana/grafana.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/nginx/nginx-depl.yaml

