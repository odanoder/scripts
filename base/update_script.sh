#!/bin/bash

# Функция для обновления списка пакетов
update_list() {
    echo "Обновление списка пакетов..."
    sudo apt update > /dev/null 2>&1
    echo -e "\n###**********###"
    echo "Список пакетов обновлен"
    echo "Package list updated"
    echo -e "\n###**********###"
}

# Функция для обновления списка пакетов и установки обновлений
update_and_upgrade() {
    echo "Обновление списка пакетов и установка обновлений..."
    sudo apt update > /dev/null 2>&1
    result=$(sudo apt upgrade -y 2>&1 | tail -n 1)
    echo -e "\n###**********###"
    echo "Список пакетов обновлен, пакеты установлены:"
    echo "Package list updated, packages installed:"
    echo "$result"
    echo -e "\n###**********###"
}

# Главное меню
echo "Выберите действие:"
echo "1. Обновить список пакетов"
echo "2. Обновить список пакетов и установить обновления"
read -p "Введите номер (1 или 2): " choice

case $choice in
    1)
        update_list
        ;;
    2)
        update_and_upgrade
        ;;
    *)
        echo "Неверный выбор. Пожалуйста, введите 1 или 2."
        ;;
esac
