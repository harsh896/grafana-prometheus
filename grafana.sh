#!/bin/bash

# Install required packages
echo -e "\033[0;33m Installing apt-transport-https software-properties-common wget systemd.........................\033[0m \n"
sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget systemd
echo -e "\n"

#Adding key
echo -e "\033[0;36m Adding Grafan Key.........................\033[0m \n"
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo -e "\n"

#Copying Deb to /etc/apt/sources.list.d/grafana.list
echo -e "\033[0;33m Copying Deb to /etc/apt/sources.list.d/grafana.list.........................\033[0m \n"
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
echo -e "\n"

# Apt updating and Installing Grafana
echo -e "\033[0;32m Apt update and installing grafana.........................\033[0m \n"
sudo apt-get update
sudo apt-get install grafana -y 
echo -e "\n"

# Start & enabling grafana server with systemd
echo -e "\033[0;32m Start & enabling grafana server with systemd.........................\033[0m \n"
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl enable grafana-server.service
echo -e "\n"
