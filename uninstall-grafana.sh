#!/bin/bash

# Stopping grafana server
echo -e "\033[0;31m Stopping grafana service.......................................................\033[0m \n"
sudo systemctl stop grafana-server
echo -e "\n"

# Removing grafana server
echo -e "\033[0;31m Removing grafana server........................................................\033[0m \n"
sudo apt-get purge grafana -y
echo -e "\n"

# Removing prometheus directories
echo -e "\033[0;33m Removing grafana directory.....................................................\033[0m \n"
sudo rm -rf /etc/grafana
echo -e "\n"

# Removing /etc/apt/sources.list.d/grafana.list deb file
echo -e "\033[0;33m Removing /etc/apt/sources.list.d/grafana.list deb file.........................\033[0m \n"
sudo rm /etc/apt/sources.list.d/grafana.list
echo -e "\n"