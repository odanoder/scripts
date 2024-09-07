#!/bin/bash

# Установка Docker с использованием официального скрипта
install_docker_official() {
    echo "Установка Docker с использованием официального скрипта..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    echo "Docker установлен с использованием официального скрипта."
}

# Установка Docker с добавлением пользователя в группу Docker
install_docker_official_with_usermod() {
    echo "Установка Docker с использованием официального скрипта и добавлением пользователя в группу Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    sudo usermod -aG docker $USER
    echo "Docker установлен и пользователь добавлен в группу Docker."
}

# Выбор варианта установки
echo "Выберите вариант установки Docker:"
echo "1) Установка Docker с использованием официального скрипта"
echo "2) Установка Docker с добавлением пользователя в группу Docker"
read -p "Введите номер варианта (1 или 2): " choice

case $choice in
    1)
        install_docker_official
        ;;
    2)
        install_docker_official_with_usermod
        ;;
    *)
        echo "Неверный выбор. Выход..."
        exit 1
        ;;
esac

echo "Готово."
