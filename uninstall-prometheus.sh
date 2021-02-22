#!/bin/bash

# Stopping prometheus and node_exporter service
echo -e "\033[0;31m Stopping prometheus and node_exporter service..................................\033[0m \n"
sudo systemctl stop prometheus
sudo systemctl stop node_exporter
echo -e "\n"

# Removing prometheus directories
echo -e "\033[0;33m Removing Prometheus Directories................................................\033[0m \n"
sudo rm -rf /etc/prometheus
sudo rm -rf /var/lib/prometheus
echo -e "\n"

# Removing installers and service files
echo -e "\033[0;33m Removing installers and service files..........................................\033[0m \n"
sudo rm /usr/local/bin/prometheus
sudo rm /usr/local/bin/promtool
sudo rm /usr/local/bin/node_exporter
sudo rm /etc/systemd/system/prometheus.service
sudo rm /etc/systemd/system/node_exporter.service
echo -e "\n"

# Deleting Users Prometheus and node_exporter
echo -e "\033[0;33m Deleting Users Prometheus and node_exporter....................................\033[0m \n"
sudo deluser prometheus
sudo deluser node_exporter
echo -e "\n"