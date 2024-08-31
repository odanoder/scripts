#!/bin/bash

# Функция для создания пользователя
create_user() {
    local default_name="$1"
    local add_sudo="$2"

    echo "Введите имя пользователя (по умолчанию: $default_name):"
    read -r username

    # Если имя пользователя не введено, используем имя по умолчанию
    username=${username:-$default_name}

    # Создание пользователя
    sudo adduser "$username"

    # Если указан параметр sudo, предложить варианты добавления в группы
    if [ "$add_sudo" = "yes" ]; then
        echo "Выберите группы для добавления:"
        echo "1) sudo"
        echo "2) docker"
        echo "Введите номера групп через пробел (например, 1 2):"
        read -r groups_choice

        for group in $groups_choice; do
            case $group in
                1)
                    sudo usermod -aG sudo "$username"
                    ;;
                2)
                    sudo usermod -aG docker "$username"
                    ;;
                *)
                    echo "Неверный выбор группы: $group"
                    ;;
            esac
        done
    fi

    # Вывод данных о пользователе
    home_dir=$(getent passwd "$username" | cut -d: -f6)
    if [ -d "$home_dir" ]; then
        home_dir_status="$home_dir"
    else
        home_dir_status="false"
    fi
    groups=$(id -Gn "$username" | tr ' ' ',')

    echo "Пользователь: $username"
    echo "Домашний каталог: $home_dir_status"
    echo "Группы: $groups"
}

# Главное меню
while true; do
    echo "Выберите тип пользователя для создания:"
    echo "1) User для авторизации (no sudo)"
    echo "2) Base user"
    echo "3) Выход"

    read -r choice

    case $choice in
        1)
            create_user "monitoring" "no"
            ;;
        2)
            create_user "admin" "yes"
            ;;
        3)
            echo "Выход из программы."
            break
            ;;
        *)
            echo "Неверный выбор. Пожалуйста, попробуйте снова."
            ;;
    esac
    echo "----------------------------------------"
done
