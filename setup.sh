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

echo "${RED}"
echo "#######################################################################"
echo "#                                                                     #"
echo "# ----- -----          ---  ----- ----  |   | -----   --  -----  ---  #"
echo "# |       |           |     |     |   | \\   /   |    /  \\ |     |     #"
echo "# |--     |             \\   |--   ----   | |    |   |     |--     \\   #"
echo "# |       |               | |     | \\    | |    |    \\  / |         | #"
echo "# |       |    _____   ---  ----- |   \\   -   -----   --  -----  ---  #"
echo "#                                                                     #"
echo "#######################################################################"
echo "${NC}"


apply_yaml()
{
	# apply metallb
	
	echo "${ORANGE}Applying metallb${NC}"
	kubectl apply -f ./srcs/metallb.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"

	# apply volume

	echo "${ORANGE}Applying volumes${NC}"

	echo "${ORANGE}influxdb volumes..${NC}"
	kubectl apply -f ./srcs/influxdb/influxdb-volume.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
	echo "${ORANGE}mysql volumes..${NC}"
	kubectl apply -f ./srcs/mysql/mysql-volume.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"

	# start databases

	echo "${ORANGE}Applying databases${NC}"

	echo "${ORANGE}mysql..${NC}"
	kubectl apply -f ./srcs/mysql/mysql.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
	echo "${ORANGE}influxdb..${NC}"
	kubectl apply -f ./srcs/influxdb/influxdb.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"


	sleep 5
	# start deployments

	echo "${ORANGE}Applying deployments${NC}"
	
	echo "${ORANGE}grafana..${NC}"
	kubectl apply -f ./srcs/grafana/grafana.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
	echo "${ORANGE}phpmyadmin..${NC}"
	kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
	echo "${ORANGE}wordpress..${NC}"
	kubectl apply -f ./srcs/wordpress/wordpress.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
	echo "${ORANGE}ftps..${NC}"
	kubectl apply -f ./srcs/ftps/ftps.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
	echo "${ORANGE}nginx..${NC}"
	kubectl apply -f ./srcs/nginx/nginx.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
	echo "${ORANGE}telegraf..${NC}"
	kubectl apply -f ./srcs/telegraf/telegraf.yaml >> ./srcs/log/logs
	echo "${GREEN}Done !${NC}"
}

build_image()
{
	echo "${ORANGE}wordpress image building...${NC}"
	docker build -t wp-img ./srcs/wordpress/. >> ./srcs/log/logs
	echo "${GREEN}done !\n"
	echo "${ORANGE}mysql image building...${NC}"
	docker build -t mysql-img ./srcs/mysql/. >> ./srcs/log/logs
	echo "${GREEN}done !\n"
	echo "${ORANGE}phpmyadmin image building...${NC}"
	docker build -t php-img ./srcs/phpmyadmin/. >> ./srcs/log/logs
	echo "${GREEN}done !\n"
	echo "${ORANGE}nginx image building...${NC}"
	docker build -t nginx-img ./srcs/nginx/. >> ./srcs/log/logs
	echo "${GREEN}done !\n"
	echo "${ORANGE}ftps image building...${NC}"
	docker build -t ftps-img ./srcs/ftps/. >> ./srcs/log/logs
	echo "${GREEN}done !\n"
	echo "${ORANGE}influxdb image building...${NC}"
	docker build -t influxdb-img ./srcs/influxdb/. >> ./srcs/log/logs
	echo "${GREEN}done !\n"
	echo "${ORANGE}grafana image building...${NC}"
	docker build -t grafana-img ./srcs/grafana/. >> ./srcs/log/logs
	echo "${GREEN}done !\n"
}

start_minikube()
{
	minikube delete >> ./srcs/log/logs
	minikube start --vm-driver=docker >> ./srcs/log/logs
}

install_metallb()
{
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml >> ./srcs/log/logs
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml >> ./srcs/log/logs
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" >> ./srcs/log/logs 
}

install_minikube()
{
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.18.1/minikube-linux-amd64 >> ./srcs/log/logs 2>&1; \
    	chmod +x minikube >> ./srcs/log/logs; \
    	sudo mkdir -p /usr/local/bin/; \
    	sudo install minikube /usr/local/bin/ >> ./srcs/log/logs
    	rm minikube
}

check_installation()
{
	# check if docker is installed

	docker --version > /dev/null
	if [ $? != 0 ]
	then
		sudo apt-get install docker >> ./srcs/log/logs
	else
		echo "${GREEN}Well, well, well ... docker is already installed\n${NC}"
	fi

	# check if you have minikube installed and the right version

	minikube version > /dev/null 2>&1
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

rm -rf ./srcs/log > /dev/null
mkdir -p ./srcs/log > /dev/null
touch ./srcs/log/logs > /dev/null

echo "${ORANGE}Please give me the permission to work (user42): ${NC}"
sudo ls / > /dev/null

echo "${ORANGE}First step, i'm gonna check your installation${NC}\n"
check_installation
echo "${GREEN}Installation checking done !${NC}\n"

echo "${ORANGE}Step two, i'm starting minikube${NC}"
start_minikube
echo "${GREEN}Done !${NC}"


echo "${ORANGE}Step three, i'm installing metallb${NC}"
install_metallb
echo "${GREEN}Done !${NC}"

echo "${ORANGE}Step four, i'm installing Filezilla${NC}"
sudo apt-get install filezilla >> ./srcs/log/logs
echo "${GREEN}Done !${NC}"


eval $(minikube docker-env)

echo "${ORANGE}Well, now hard work begins !\nWe are going to build your image. In you interest, i hope you like staying watching the screen during a while${NC}"
build_image

echo "${ORANGE}Your images are built, Good ! Last hard step, applying your .yaml files${NC}"
apply_yaml
echo "${GREEN}Well Done !${NC}"

echo "${CYAN}We have finished the work. Now i'm gonna launch for you the dashboard. Enjoy !${NC}"
minikube dashboard >> ./srcs/log/logs
