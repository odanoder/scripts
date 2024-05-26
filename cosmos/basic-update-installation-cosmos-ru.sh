#!/bin/bash

# Функция для вывода сообщения об ошибке
error_message() {
    echo "Ошибка: $1"
}

# Функция для выполнения команды с проверкой на успешное выполнение и логированием
execute_command() {
    "$@" | tee -a /tmp/package-log.txt
    local status=${PIPESTATUS[0]}
    if [ $status -ne 0 ]; then
        error_message "Команда \"$@\" завершилась с ошибкой (код $status)."
        exit $status
    fi
}

# Инициализация лог файла
> /tmp/package-log.txt

# Обновление списка пакетов
execute_command sudo apt update
execute_command sudo apt upgrade -y

# Списки пакетов для установки
base_utils="coreutils nano htop wget curl tmux"
archivers="tar zip unzip lz4"
dirs_disks="tree pstree ncdu nvme-cli"
network="net-tools iptables"
packages="pkg-config make gcc git"
cosmos="build-essential libssl-dev libleveldb-dev jq"

# Установка пакетов: базовые утилиты
execute_command sudo apt install $base_utils -y
# Установка пакетов: архиваторы
execute_command sudo apt install $archivers -y
# Установка пакетов: работа с директориями и дисками
execute_command sudo apt install $dirs_disks -y
# Установка пакетов: работа с сетью
execute_command sudo apt install $network -y
# Установка пакетов: работа с пакетами
execute_command sudo apt install $packages -y
# Установка пакетов: для cosmos
execute_command sudo apt install $cosmos -y

# Обработка и вывод логов
all_packages="$base_utils $archivers $dirs_disks $network $packages $cosmos"
installed_packages=$(grep -E "Setting up" /tmp/package-log.txt | awk '{print $2}')
updated_packages=$(grep -E "upgraded" /tmp/package-log.txt | awk '{print $1}')
already_installed_packages=$(grep -E "already the newest version" /tmp/package-log.txt | awk '{print $1}')

echo "Все пакеты которые были в скрипте:"
for pkg in $all_packages; do
    echo "- $pkg"
done

echo ""
echo "Обновленные пакеты:"
for pkg in $updated_packages; do
    echo "- $pkg"
done

echo ""
echo "Установленные пакеты:"
for pkg in $installed_packages; do
    echo "- $pkg"
done

echo ""
echo "Уже были установлены:"
for pkg in $already_installed_packages; do
    echo "- $pkg"
done
