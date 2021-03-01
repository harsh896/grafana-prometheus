#!/bin/bash
PROMETHEUS_VERSION='2.22.1'
NODE_EXPORTER_VERSION='1.1.0'

if [ -f /usr/local/bin/prometheus ]
then
    prometheus --version
    echo -e "\n\033[0;32mPrometheus already installed. \033[0m \n"
else
    echo ".......................................................INSTALLING PROMETHEUS......................................................."
    
    # Removing prometheus tar from current directory
    echo -e "\033[0;32m Removing prometheus tar from current directory.............................\033[0m \n"
    sudo rm -rf prometheus-*
    echo -e "\n"

    # Updating
    echo -e "\033[0;31m Updating and installing wget systemd.......................................\033[0m \n"
    sudo apt-get update
    sudo apt-get install wget systemd -y
    echo -e "\n"

    # Add prometheus user
    echo -e "\033[0;32m Creating Prometheus User...................................................\033[0m \n"
    sudo useradd --no-create-home --shell /bin/false prometheus
    echo -e "\n"

    # Download prometheus tar file
    echo -e "\033[0;32m Downloading Prometheus Tar file............................................\033[0m \n"
    wget https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
    echo -e "\n"

    # Extract tar file
    echo -e "\033[0;36m Extracting Tar file........................................................\033[0m \n"
    tar xvf prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
    echo -e "\n"

    # Copy intallers to /usr/local/bin/directory
    echo -e "\033[0;33m Coping installer to /usr/local/bin/........................................\033[0m \n"
    sudo cp prometheus-$PROMETHEUS_VERSION.linux-amd64/prometheus /usr/local/bin/
    sudo cp prometheus-$PROMETHEUS_VERSION.linux-amd64/promtool /usr/local/bin/
    echo -e "\n"

    # Change ownership of those installers
    echo -e "\033[0;33m Changing Ownership of installers...........................................\033[0m \n"
    sudo chown prometheus:prometheus /usr/local/bin/prometheus
    sudo chown prometheus:prometheus /usr/local/bin/promtool
    echo -e "\n"
    
    # Make directories for prometheus
    echo -e "\033[0;32m Creating Directiries for Prometheus........................................\033[0m \n"
    sudo mkdir /etc/prometheus
    sudo mkdir /var/lib/prometheus
    echo -e "\n"

    # Change ownership for above created directories
    echo -e "\033[0;33m Changing Ownership of directories..........................................\033[0m \n"
    sudo chown prometheus:prometheus /etc/prometheus
    sudo chown prometheus:prometheus /var/lib/prometheus
    echo -e "\n"
    
    # Copy console and console libraries to /etc/prometheus
    echo -e "\033[0;33m Copy console and console libraries to /etc/prometheus......................\033[0m \n"
    sudo cp -r prometheus-$PROMETHEUS_VERSION.linux-amd64/consoles /etc/prometheus
    sudo cp -r prometheus-$PROMETHEUS_VERSION.linux-amd64/console_libraries /etc/prometheus
    echo -e "\n"

    # Change ownership of console and console libraries
    echo -e "\033[0;33m Changing ownership of console and console libraries........................\033[0m \n"
    sudo chown -R prometheus:prometheus /etc/prometheus/consoles
    sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
    echo -e "\n"

    # Creating Prometheus.yml file and changing ownership of the file
    echo -e "\033[0;32m Creating Prometheus.yml file and changing ownership of the file............\033[0m \n"
    sudo cp prometheus/prometheus.yml /etc/prometheus/prometheus.yml
    sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
    echo -e "\n"

    # Running prometheus command and creating prometheus.service file
    echo -e "\033[0;32m Running prometheus command and creating prometheus.service file............\033[0m \n"
    sudo cp prometheus/prometheus.service /etc/systemd/system/prometheus.service
    echo -e "\n"

    # Starting and enabling prometheus
    echo -e "\033[0;36m Starting and enabling prometheus...........................................\033[0m \n"
    sudo systemctl daemon-reload
    sudo systemctl start prometheus
    sudo systemctl enable prometheus
    echo -e "\n"

fi
