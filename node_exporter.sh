#!/bin/bash
NODE_EXPORTER_VERSION='1.1.0'

if [ -f /usr/local/bin/node_exporter ]
then
    prometheus --version
    echo -e "\n\033[0;32mNode Exporter already installed. \033[0m \n"
else
    echo ".......................................................INSTALLING NODE EXPORTER......................................................."
    
    # Removing node_exporter tar from current directory
    echo -e "\033[0;32m Removing node_exporter tar from current directory..........................\033[0m \n"
    sudo rm -rf node_exporter-*
    echo -e "\n"

    # Updating
    echo -e "\033[0;31m Updating and installing wget systemd.......................................\033[0m \n"
    sudo apt-get update
    sudo apt-get install wget systemd -y
    echo -e "\n"

    # Add prometheus and node expoeter user
    echo -e "\033[0;32m Creating Node_Exporter User................................................\033[0m \n"
    sudo useradd --no-create-home --shell /bin/false node_exporter
    echo -e "\n"

    #Downloading Node Exporter
    echo -e "\033[0;32m Downloading Node Exporter..................................................\033[0m \n"
    wget https://github.com/prometheus/node_exporter/releases/download/v$NODE_EXPORTER_VERSION/node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
    echo -e "\n"

    # Extract tar file
    echo -e "\033[0;36m Extracting Tar file........................................................\033[0m \n"
    tar xvf node_exporter-$NODE_EXPORTER_VERSION.linux-amd64.tar.gz
    echo -e "\n"

    # Copy node_exporter installer to /usr/local/bin
    echo -e "\033[0;33m Coping node_exporter installer to /usr/local/bin...........................\033[0m \n"
    sudo cp node_exporter-$NODE_EXPORTER_VERSION.linux-amd64/node_exporter /usr/local/bin/
    echo -e "\n"

    # Change ownership of those installer
    echo -e "\033[0;33m Changing Ownership of installer............................................\033[0m \n"
    sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter
    echo -e "\n"
   
    # Creating node_exporter service file
    echo -e "\033[0;33m Changing Ownership of installers...........................................\033[0m \n"
    sudo cp node_exporter/node_exporter.service /etc/systemd/system/node_exporter.service
    echo -e "\n"

    # Starting and enabling node_exporter
    echo -e "\033[0;36m Starting and enabling node_exporter........................................\033[0m \n"
    sudo systemctl daemon-reload
    sudo systemctl start node_exporter
    sudo systemctl enable node_exporter
    echo -e "\n"

fi
