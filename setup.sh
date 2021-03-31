###############
#### COLOR ####
###############

RED='\e[1;31m'
GREEN='\e[1;32m'
ORANGE='\e[1;33m'
BLUE='\e[1;34m'
MAGENTA='\e[1;35m'
CYAN='\e[1;36m'
NC='\e[0m'

#####################
#### FT_SERVICES ####
#####################

apply_yaml()
{
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
	kubectl apply -f ./srcs/ftps/ftps.yaml
	kubectl apply -f ./srcs/nginx/nginx.yaml
	kubectl apply -f ./srcs/telegraf/telegraf.yaml
}

build_image()
{
	docker build -t wp-img ./srcs/wordpress/.
	docker build -t mysql-img ./srcs/mysql/.
	docker build -t php-img ./srcs/phpmyadmin/.
	docker build -t nginx-img ./srcs/nginx/.
	docker build -t ftps-img ./srcs/ftps/.
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

install_minikube()
{
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.18.1/minikube-linux-amd64 > /dev/null 2>&1; \
    	chmod +x minikube > /dev/null; \
    	sudo mkdir -p /usr/local/bin/; \
    	sudo install minikube /usr/local/bin/
    	rm minikube
}

check_installation()
{
	# check if docker is installed

	docker --version > /dev/null
	if [ $? != 0 ]
	then
		sudo apt-get install docker > /dev/null
	else
		echo "${GREEN}Well, well, well ... docker is already installed\n${NC}"
	fi

	# check if you have minikube installed and the right version

	minikube version > /dev/null
	if [ $? != 0 ]
	then
		echo "${ORANGE}You don't have minikube..."
		echo "But don't worry i'm starting the installation${NC}"
		install_minikube
		echo "${GREEN}Okey, it's done !${NC}\n"
	else
		echo "${GREEN}Good ! you have minikube${NC}"
		if [ $(minikube version | grep "version" | sed -n -e 's/^.*: //p') = "v1.18.1" ]
		then
			echo "${GREEN}In addition, you have the good minikube version for the project."
			sleep 2
			echo "Less work, that's sound good for me !${NC}"
		else
			echo "${ORANGE}You don't have the good minikube version for the project..."
			sleep 4
			echo "Don't panic ! I'm installing the right one !${NC}"
			install_minikube
			echo "${GREEN}It's done !${NC}\n"
		fi
	fi
}

check_installation

#start_minikube

#install_metallb

# install FileZilla
#sudo apt-get install filezilla

#eval $(minikube docker-env)

#build_image

#apply_yaml
