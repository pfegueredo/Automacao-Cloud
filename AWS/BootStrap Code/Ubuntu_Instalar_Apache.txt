#!/bin/bash
apt update -y
apt install apache2 -y
cd /var/www/html
echo "Servidor Funcionando" > funcionando.html