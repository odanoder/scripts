#!/bin/bash

# Установка Node Exporter

# Запрос порта у пользователя
read -p "Введите порт для Node Exporter или нажмите Enter для использования порта по умолчанию (9100): " port
port=${port:-9100}

# Создание пользователя node_exporter
sudo useradd --no-create-home --shell /bin/false node_exporter

# Переход в домашний каталог
cd ~

# Загрузка Node Exporter
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.2/node_exporter-1.8.2.linux-amd64.tar.gz || { echo "Ошибка загрузки файла"; exit 1; }

# Распаковка архива
tar xvf node_exporter-1.8.2.linux-amd64.tar.gz || { echo "Ошибка распаковки архива"; exit 1; }

# Переход в распакованную директорию
cd node_exporter-1.8.2.linux-amd64

# Перемещение бинарного файла в /usr/local/bin
sudo cp node_exporter /usr/local/bin/

# Назначение владельца файла
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Проверка версии Node Exporter
node_exporter --version

# Создание сервисного файла systemd
sudo tee /etc/systemd/system/node_exporterd.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
ExecStart=/usr/local/bin/node_exporter --web.listen-address=:$port

# Настройки перезапуска
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

# Перезапуск systemd и активация службы
sudo systemctl daemon-reload
sudo systemctl enable node_exporterd
sudo systemctl restart node_exporterd

# Проверка статуса сервиса
sudo systemctl status node_exporterd

# Проверка, что метрики отдаются
curl "localhost:$port/metrics" || { echo "Node Exporter не доступен"; exit 1; }

# Вывод ссылки для просмотра метрик в браузере
echo -e "\033[0;32mhttp://$(curl -s ifconfig.me):$port/\033[0m"
