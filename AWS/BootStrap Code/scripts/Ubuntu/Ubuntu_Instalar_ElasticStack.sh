#!/bin/bash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update && sudo apt-get install openjdk-8-jre-headless elasticsearch logstash kibana filebeat
systemctl enable elasticsearch
systemctl start elasticsearch
systemctl start kibana

#Habilitar dashboards do filebeat para o Kibana
cd /usr/share/filebeat/bin/
filebeat setup --dashboards

#Reiniciar o Kibana para que ele possa ver o dashboard
systemctl restart kibana
