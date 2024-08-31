#!/bin/bash

# Обновление системы
sudo apt update && sudo apt upgrade -y

# Установка необходимых пакетов
sudo apt install -y curl tar wget nano tmux htop iptables git python3-pip jq ncdu nvme-cli build-essential gcc make clang pkg-config libssl-dev libleveldb-dev unzip

# Создание пользователя для Prometheus
sudo useradd --no-create-home --shell /bin/false prometheus

# Создание необходимых каталогов и установка прав
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

# Скачивание и установка Prometheus
cd ~
wget https://github.com/prometheus/prometheus/releases/download/v2.53.2/prometheus-2.53.2.linux-amd64.tar.gz
tar -xvf prometheus-2.53.2.linux-amd64.tar.gz
cd prometheus-2.53.2.linux-amd64
sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo cp -r consoles /etc/prometheus
sudo cp -r console_libraries /etc/prometheus
sudo cp prometheus.yml /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown -R prometheus:prometheus /var/lib/prometheus

# Проверка версий
prometheus --version
promtool --version

# Запрос порта для Prometheus
echo "Введите порт для Prometheus (по умолчанию 9090):"
read -r port
port=${port:-9090}

# Создание файла сервиса systemd для Prometheus
sudo tee /etc/systemd/system/prometheusd.service > /dev/null <<EOF
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
    --config.file /etc/prometheus/prometheus.yml \
    --storage.tsdb.path /var/lib/prometheus/ \
    --web.console.templates=/etc/prometheus/consoles \
    --web.console.libraries=/etc/prometheus/console_libraries \
    --web.listen-address=:${port}

[Install]
WantedBy=multi-user.target
EOF

# Перезагрузка systemd, запуск и включение сервиса
sudo systemctl daemon-reload
sudo systemctl start prometheusd
sudo systemctl enable prometheusd

# Задержка для проверки
sleep 10

# Проверка статуса сервиса
sudo systemctl status prometheusd

# Вывод URL для проверки
echo -e "\033[0;32mhttp://$(wget -qO- eth0.me):${port}/\033[0m"
