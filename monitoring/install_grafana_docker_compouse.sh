#!/bin/bash

# Запрос порта у пользователя
read -p "Введите порт, на котором будет работать Grafana (по умолчанию 3000): " grafana_port

# Если порт не указан, используем значение по умолчанию
if [ -z "$grafana_port" ]; then
  grafana_port=3000
fi

# Путь для сохранения данных на хосте
read -p "Введите путь для сохранения данных Grafana на хосте (по умолчанию /var/lib/grafana): " grafana_data_path

# Если путь не указан, используем значение по умолчанию
if [ -z "$grafana_data_path" ]; then
  grafana_data_path="/var/lib/grafana"
fi

# Создание файла docker-compose.yml
cat <<EOF > docker-compose.yml

services:
  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    ports:
      - "$grafana_port:3000"
    volumes:
      - $grafana_data_path:/var/lib/grafana
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
    restart: always

volumes:
  grafana-data:
    external: true
EOF

# Сообщение пользователю
echo "Файл docker-compose.yml создан с портом $grafana_port и сохранением данных в $grafana_data_path."

# Запуск Grafana с использованием новой версии Docker Compose
docker compose up -d
