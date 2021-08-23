
echo "Criando um um usuario prometheus e adicionando ao grupo system"
groupadd --system prom_node_exporter
useradd -s /bin/false -r -g prom_node_exporter prom_node_exporter
echo " "

echo "Realizando download do prometheus..."
mkdir /downloads/prom_node_exporter -p
cd /downloads/prom_node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.0/node_exporter-1.2.0.linux-amd64.tar.gz 
echo " "

echo "Extraindo o pacote..."
tar -zxvf node_exporter-1.2.0.linux-amd64.tar.gz
echo " "

echo "Instalando o node exporter..."
cd /downloads/prom_node_exporter/node_exporter-1.2.0.linux-amd64
install node_exporter /usr/local/bin/
#install promtool /usr/local/bin/
#mv consoles /etc/prometheus/
#mv console_libraries /etc/prometheus/
#echo "Versão instalada: "
#node_exporter -version
echo " "

#echo "Criando arquivo de configuracao do node_exporter..."
#cd /etc/prometheus
#touch prometheus.yml
#echo "global:" >> prometheus.yml
#echo "  scrape_interval: 15s" >> prometheus.yml
#echo "" >> prometheus.yml

#echo "scrape_configs:" >> prometheus.yml
#echo "  - job_name: 'prom_node_exporter'" >> prometheus.yml
#echo "    scrape_interval: 5s"  >> prometheus.yml
#echo "    static_configs:" >> prometheus.yml
#echo "      - targets: ['localhost:9100']" >> prometheus.yml
#echo " "

#echo "Configurando permissões dos arquivos..."
#chown prometheus:prometheus /usr/local/bin/prometheus
#chown prometheus:prometheus /usr/local/bin/promtool
#chown prometheus:prometheus /var/lib/prometheus -R
#chown prometheus:prometheus /etc/prometheus -R
#chmod -R 775 /etc/prometheus/ /var/lib/prometheus/
#echo " "
#echo "Iniciando o prometheus..."
#prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries
echo " "

echo "Configurando o servico para iniciar..."
touch /etc/systemd/system/prom_node_exporter.service
echo -e "[Unit]\nDescription=Prometheus Node Exporter\nWants=network-online.target\nAfter=network-online.target\n[Service]\nUser=prom_node_exporter\nGroup=prom_node_exporter\nType=simple\nExecStart=/usr/local/bin/node_exporter\nRestart=always\n\n[Install]\nWantedBy=multi-user.target" >> /etc/systemd/system/prom_node_exporter.service
echo " "

echo "Ativando o serviço"
#chown prometheus:prometheus /var/lib/prometheus -R
#chmod 775 /var/lib/prometheus -R
systemctl daemon-reload
systemctl enable prom_node_exporter
systemctl start prom_node_exporter
echo " "
echo "Status do servico: "
systemctl status prom_node_exporter.service
echo "Node Exporter instalado com exito"
