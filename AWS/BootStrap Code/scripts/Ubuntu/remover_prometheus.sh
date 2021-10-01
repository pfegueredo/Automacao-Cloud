rm -rf /download/prometheus
rm -rf /etc/prometheus/
rm -rf /usr/local/bin/prometheus
rm -rf /usr/local/bin/promtool
rm -rf /var/lib/prometheus
rm -rf /etc/systemd/system/prometheus.service
rm -rf /etc/systemd/system/prom_node_exporter.service
systemctl daemon-reload
systemctl disable prometheus
systemctl stop prometheus
echo "Desinstalação concluida com sucesso"

