#!/bin/bash

# Установка необходимых пакетов
sudo apt update
sudo apt install -y wget tar

# Создание пользователя для node_exporter
sudo useradd --no-create-home --shell /bin/false node_exporter

# Создание директорий для хранения данных и конфигураций
sudo mkdir -p /etc/node_exporter
sudo mkdir -p /var/lib/node_exporter

# Загрузка и установка node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz
tar -xvf node_exporter-1.8.2.linux-amd64.tar.gz

# Перемещение бинарных файлов в /usr/local/bin
sudo cp node_exporter-1.8.2.linux-amd64/node_exporter /usr/local/bin/

# Установка прав для пользователя node_exporter
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Удаление временных файлов
rm -rf node_exporter-1.8.2.linux-amd64.tar.gz node_exporter-1.8.2.linux-amd64

# Создание systemd сервиса для node_exporter
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Prometheus Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF

# Перезагрузка systemd и запуск node_exporter
sudo systemctl daemon-reload
sudo systemctl start node_exporter
sudo systemctl enable node_exporter

# Проверка статуса сервиса
sudo systemctl status node_exporter

# Вывод URL для проверки работы node_exporter
echo -e "\033[0;32mhttp://$(wget -qO- eth0.me):9100/metrics\033[0m"
