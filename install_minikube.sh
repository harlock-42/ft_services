curl -Lo minikube https://storage.googleapis.com/minikube/releases/v1.17.1/minikube-linux-amd64 > /dev/null 2>&1 ; \
chmod +x minikube > /dev/null 2>&1 ; \
sudo mkdir -p /usr/local/bin/ ; \
sudo install minikube /usr/local/bin/
rm minikube
