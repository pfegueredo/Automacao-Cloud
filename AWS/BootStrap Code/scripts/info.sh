#!/bin/bash
echo  "Nome do Servidor: "
hostname
echo "IP do servidor: "
ifconfig enp0s3 | grep "inet "
