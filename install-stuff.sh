sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install curl
sudo apt-get install apt-transport-https
sudo apt-get install ca-certificates
sudo apt-get install software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt update
apt-cache policy docker-cesudo
sudo apt-get install docker-ce

sudo groupadd docker
sudo usermod -aG docker $(whoami);
su - ${USER}
id -nG

sudo service nginx stop
sudo apt install virtualbox virtualbox-ext-pack

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
csudo mv ./kubectl /usr/local/bin/kubectl
