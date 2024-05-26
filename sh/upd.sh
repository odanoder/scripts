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

# Запрос на обновление информации о пакетах
read -p "Хотите обновить информацию о пакетах? (y/n): " update_choice
if [[ "$update_choice" == "y" || "$update_choice" == "Y" ]]; then
    echo "Обновляется информация о пакетах..."
    execute_command sudo apt update
else
    echo "Обновление информации о пакетах пропущено."
fi

# Запрос на обновление самих пакетов
read -p "Хотите обновить установленные пакеты? (y/n): " upgrade_choice
if [[ "$upgrade_choice" == "y" || "$upgrade_choice" == "Y" ]]; then
    echo "Обновление установленных пакетов..."
    execute_command sudo apt upgrade -y
else
    echo "Обновление установленных пакетов пропущено."
fi
