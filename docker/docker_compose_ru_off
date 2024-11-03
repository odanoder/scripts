#!/bin/bash

# Функция для добавления разделителя
print_separator() {
    echo "=================================================="
}

# Обновление пакетов
print_separator
echo -e "\e[1;34mОбновление пакетов...\e[0m"
print_separator
sudo apt update && sudo apt upgrade -y

# Проверка установки Docker
print_separator
echo -e "\e[1;33mПроверка установки Docker...\e[0m"
print_separator
if command -v docker &> /dev/null; then
    echo -e "\e[1;32mDocker уже установлен.\e[0m"
    docker --version
else
    echo -e "\e[1;31mDocker не установлен. Выполняется установка...\e[0m"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    echo -e "\e[1;32mDocker успешно установлен:\e[0m"
    docker --version
fi

# Проверка установки Docker Compose как плагина
print_separator
echo -e "\e[1;33mПроверка установки Docker Compose...\e[0m"
print_separator
if docker compose version &> /dev/null; then
    echo -e "\e[1;32mDocker Compose уже установлен.\e[0m"
    docker compose version
else
    echo -e "\e[1;31mDocker Compose не установлен. Выполняется установка...\e[0m"
    sudo apt-get install docker-compose-plugin -y
    echo -e "\e[1;32mDocker Compose успешно установлен:\e[0m"
    docker compose version
fi

# Удаление временного файла установки Docker
rm -f get-docker.sh

print_separator
echo -e "\e[1;34mСкрипт завершён.\e[0m"
print_separator
