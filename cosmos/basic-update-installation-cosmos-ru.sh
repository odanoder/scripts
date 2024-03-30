#!/bin/bash

# Функция для вывода сообщения об ошибке
error_message() {
    echo "Ошибка: $1"
}

# Функция для выполнения команды с проверкой на успешное выполнение
execute_command() {
    "$@"
    local status=$?
    if [ $status -ne 0 ]; then
        error_message "Команда \"$@\" завершилась с ошибкой (код $status)."
        exit $status
    fi
}

# Обновление списка пакетов
execute_command sudo apt update
execute_command sudo apt upgrade -y
# Установка пакетов: базовые утилиты
execute_command sudo apt install coreutils nano htop wget curl git tmux -y
# Установка пакетов: архиваторы
execute_command sudo apt install tar zip lz4 -y
# Установка пакетов: работа с директориями и дисками
execute_command sudo apt install tree ncdu -y
# Установка пакетов: работа с сетью
execute_command sudo apt install net-tools -y
# Установка пакетов: работа с пакетами
execute_command sudo apt install  gcc make -y
# Установка пакетов: для cosmos
execute_command sudo apt install  build-essential jq -y
