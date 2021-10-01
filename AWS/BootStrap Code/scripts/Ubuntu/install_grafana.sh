wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
sudo apt update
sudo apt install grafana
sudo systemctl start grafana-server
sudo systemctl enable grafana-server
echo "Servidor Grafana rodando http://127.0.0.1:3000"
echo "Crie seu usuario e senha"
