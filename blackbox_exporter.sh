#!/bin/bash
BLACKBOX_EXPORTER_VERSION='0.18.0'

if [ -f /usr/local/bin/prometheus ]
then
    blackbox_exporter --version
    echo -e "\n\033[0;32mBlackbox Exporter already installed. \033[0m \n"
else
    echo ".......................................................INSTALLING BLACKBOX EXPORTER......................................................."

    # Removing blackbox tar file from current directory if exists
    echo -e "\033[0;32m Removing blackbox tar file from current directory if exists................\033[0m \n"
    sudo rm -rf blackbox_exporter-*
    echo -e "\n"

    # Updating
    echo -e "\033[0;31m Updating and installing wget systemd.......................................\033[0m \n"
    sudo apt-get update
    sudo apt-get install wget systemd -y
    echo -e "\n"

    # Add Blackbox Exporter user
    echo -e "\033[0;32m Creating Blackbox_Exporter User............................................\033[0m \n"
    sudo useradd --no-create-home --shell /bin/false blackbox_exporter
    echo -e "\n"

    # Download Blackbox Exporter tar file
    echo -e "\033[0;32m Downloading Blackbox Exporter Tar file.....................................\033[0m \n"
    wget https://github.com/prometheus/blackbox_exporter/releases/download/v$BLACKBOX_EXPORTER_VERSION/blackbox_exporter-$BLACKBOX_EXPORTER_VERSION.linux-amd64.tar.gz
    echo -e "\n"
   
    # Extract tar file
    echo -e "\033[0;36m Extracting Tar file........................................................\033[0m \n"
    tar xvf blackbox_exporter-$BLACKBOX_EXPORTER_VERSION.linux-amd64.tar.gz
    echo -e "\n"


    # Copy blackbox_exporter intaller to /usr/local/bin/directory
    echo -e "\033[0;33m Coping blackbox_exporter installer to /usr/local/bin/......................\033[0m \n"
    sudo cp blackbox_exporter-$BLACKBOX_EXPORTER_VERSION.linux-amd64/blackbox_exporter /usr/local/bin/
    echo -e "\n"

    # Make directory for blackbox_exporter
    echo -e "\033[0;32m Creating Directory for Blackbox_Exporter...................................\033[0m \n"
    sudo mkdir /etc/blackbox_exporter
    echo -e "\n"

    # Change ownership of installer and directory
    echo -e "\033[0;33m Changing Ownership of installer and directory..............................\033[0m \n"
    sudo chown blackbox_exporter:blackbox_exporter /usr/local/bin/blackbox_exporter
    sudo chown blackbox_exporter:blackbox_exporter /etc/blackbox_exporter
    echo -e "\n"

    # Copy blackbox.yml and blackbox_exporter.service file
    echo -e "\033[0;32m Copy blackbox.yml and blackbox_exporter.service file............\033[0m \n"
    sudo cp blackbox_exporter/blackbox.yml /etc/blackbox_exporter/blackbox/yml
    sudo cp blackbox_exporter/blackbox_exporter.service /etc/systemd/system/blackbox_exporter.service
    echo -e "\n"

    # Starting and enabling blackbox_exporter
    echo -e "\033[0;36m Starting and enabling blackbox_exporter...........................\033[0m \n"
    sudo systemctl daemon-reload
    sudo systemctl start blackbox_exporter
    sudo systemctl enable blackbox_exporter
    echo -e "\n"

fi