#!/bin/bash 

# Run the following command to uninstall all conflicting packages:
# Images, containers, volumes, and networks stored in /var/lib/docker/ aren't automatically removed when you uninstall Docker.
# Запустите следующую команду, чтобы удалить все конфликтующие пакеты:
# Образы, контейнеры, тома и сети, хранящиеся в нем, /var/lib/docker/не удаляются автоматически при удалении Docker.
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
# Добавьте официальный ключ GPG Docker:
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
# Добавляем репозиторий в источники Apt:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

# Install the latest version, run:
# Установите последнюю версию, запустите:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Create the docker group:
# Создайте группу докеров:
sudo groupadd docker

# Add your user to the docker group:
# Добавьте своего пользователя в группу докеров:
sudo usermod -aG docker ${USER}

# Activate the changes to groups:
# Активируйте изменения в группах:
newgrp docker

# Configure Docker to start on boot with systemd:
# Настройте Docker для запуска при загрузке с помощью systemd:
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
