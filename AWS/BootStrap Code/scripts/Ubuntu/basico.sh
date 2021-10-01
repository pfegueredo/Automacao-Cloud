#!/bin/bash
apt update -y && apt upgrade -y
apt-get install mlocate
sudo ./install_ansible.sh
