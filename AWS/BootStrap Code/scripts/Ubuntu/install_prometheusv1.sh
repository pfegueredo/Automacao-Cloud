#!/bin/bash

echo "Criando um um usuario prometheus e adicionando ao grupo system"
groupadd --system prometheus
useradd -s /bin/false -r -g prometheus prometheus

echo "Criando os diretorios para o prometheus"
mkdir /etc/prometheus
mkdir /var/lib/prometheus
echo " "

echo "Realizando download do prometheus..."
mkdir /downloads/prometheus -p
cd /downloads/prometheus
download=prometheus-2.28.1.linux-amd64.tar.gz
if [ -e "$download" ]; then
echo "Download concluido..."
else
wget https://github.com/prometheus/prometheus/releases/download/v2.28.1/prometheus-2.28.1.linux-amd64.tar.gz
fi
echo " "

echo "Extraindo o pacote..."
tar -zxvf prometheus*.tar.gz
cd prometheus-2.28.1.linux-amd64
echo " "

echo "Instalando o prometheus..."
install prometheus /usr/local/bin/
install promtool /usr/local/bin/
mv consoles /etc/prometheus/
mv console_libraries /etc/prometheus/
echo " "

echo "Criando arquivo de configuracao..."
cd /etc/prometheus
touch prometheus.yml
echo "global:" >> prometheus.yml
echo "  scrape_interval: 15s" >> prometheus.yml
echo "" >> prometheus.yml
echo "scrape_configs:" >> prometheus.yml
echo "  - job_name: 'prometheus'" >> prometheus.yml
echo "    scrape_interval: 5s"  >> prometheus.yml
echo "    static_configs:" >> prometheus.yml
echo "      - targets: ['localhost:9090']" >> prometheus.yml

echo "  - job_name: 'prom_node_exporter'" >> prometheus.yml
echo "    scrape_interval: 5s"  >> prometheus.yml
echo "    static_configs:" >> prometheus.yml
echo "      - targets: ['localhost:9100']" >> prometheus.yml
echo " "
echo "Configurando permissões dos arquivos..."
chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool
chown prometheus:prometheus /var/lib/prometheus -R
chown prometheus:prometheus /etc/prometheus -R
chmod -R 775 /etc/prometheus/ /var/lib/prometheus/
echo " "
#echo "Iniciando o prometheus..."
#prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries
echo " "

echo "Configurando o servico para iniciar..."
touch /etc/systemd/system/prometheus.service
echo -e "[Unit]\nDescription=Prometheus\nWants=network-online.target\nAfter=network-online.target\n[Service]\nUser=prometheus\nGroup=prometheus\nType=simple\nExecStart=/usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries\n[Install]\nWantedBy=multi-user.target\nSyslogIdentifier=prometheus\nRestart=always" >> /etc/systemd/system/prometheus.service
echo " "
echo "Ativando o serviço"
chown prometheus:prometheus /var/lib/prometheus -R
chmod 775 /var/lib/prometheus -R
systemctl daemon-reload
systemctl enable prometheus
systemctl start prometheus
echo " "
systemctl status prometheus
echo "Serviço Prometheus rodando na porta 9090"
