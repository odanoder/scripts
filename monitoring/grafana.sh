#!/bin/bash

# Установка необходимых пакетов
sudo apt-get update
sudo apt-get install -y apt-transport-https software-properties-common wget

# Импорт ключа GPG
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

# Добавление репозиториев
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

# Установка дополнительных пакетов
sudo apt-get update
sudo apt-get install -y adduser libfontconfig1 musl

# Скачивание и установка Grafana
wget https://dl.grafana.com/oss/release/grafana_11.2.0_amd64.deb
sudo dpkg -i grafana_11.2.0_amd64.deb

# Перезагрузка и запуск сервиса Grafana
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl restart grafana-server

# Вывод URL для доступа к Grafana
echo -e "\033[0;32mhttp://$(wget -qO- eth0.me):3000/\033[0m"