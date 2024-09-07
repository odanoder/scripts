#!/bin/bash

# Запрос порта для node_exporter
read -p "Введите порт для node_exporter (по умолчанию 9100): " PORT

# Установка порта по умолчанию, если пользователь не ввел значение
PORT=${PORT:-9100}

# Проверка, что введенный порт является числом и находится в диапазоне 1-65535
if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
  echo "Ошибка: Порт должен быть числом в диапазоне от 1 до 65535."
  exit 1
fi

# Создание директории для Docker Compose
mkdir -p ~/node_exporter

# Создание файла docker-compose.yml
cat <<EOF > ~/node_exporter/docker-compose.yml
version: '3.8'

services:
  node_exporter:
    image: quay.io/prometheus/node-exporter:latest
    container_name: node_exporter
    command:
      - '--path.rootfs=/host'
    network_mode: host
    pid: host
    restart: unless-stopped
    volumes:
      - '/:/host:ro,rslave'
    ports:
      - "$PORT:9100"
EOF

# Переход в директорию и запуск Docker Compose
cd ~/node_exporter
docker compose up -d

# Проверка статуса контейнера
echo "Проверка статуса контейнера node_exporter..."
docker compose ps
