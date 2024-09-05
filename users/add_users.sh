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

    # Если указан параметр sudo, добавить пользователя в группу sudo
    if [ "$add_sudo" = "yes" ]; then
        sudo usermod -aG sudo "$username"
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

# Функция для добавления пользователя в группы
add_to_groups() {
    echo "Введите имя пользователя, которого нужно добавить в группы:"
    read -r username

    if ! id "$username" &>/dev/null; then
        echo "Пользователь $username не существует."
        return
    fi

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

    echo "Пользователь $username добавлен в указанные группы."
}

# Функция для изменения порта SSH
change_ssh_port() {
    echo "Введите новый порт для SSH:"
    read -r new_port

    # Проверка, что порт является числом и находится в допустимом диапазоне
    if [[ ! "$new_port" =~ ^[0-9]+$ ]] || [ "$new_port" -lt 1 ] || [ "$new_port" -gt 65535 ]; then
        echo "Неверный порт. Пожалуйста, введите числовое значение от 1 до 65535."
        return
    fi

    # Замена порта в конфигурационном файле
    sudo sed -i "s/^#Port 22/Port $new_port/" /etc/ssh/sshd_config

    # Вывод нового порта из конфигурационного файла
    grep "^Port" /etc/ssh/sshd_config

    # Перезапуск SSH сервиса
    sudo systemctl restart ssh
    echo "Порт SSH изменен на $new_port и служба SSH перезапущена."
}

# Функция для изменения PermitRootLogin
change_permit_root_login() {
    echo "Введите новое значение для PermitRootLogin (yes/no/prohibit-password):"
    read -r new_value

    # Изменение PermitRootLogin в конфигурационном файле
    sudo sed -i "s/^#PermitRootLogin .*/PermitRootLogin $new_value/" /etc/ssh/sshd_config

    # Если значение отличается от "prohibit-password", убедиться, что строка активна
    if [[ "$new_value" != "prohibit-password" ]]; then
        sudo sed -i "s/^PermitRootLogin .*/PermitRootLogin $new_value/" /etc/ssh/sshd_config
    fi

    # Перезапуск SSH сервиса
    sudo systemctl restart ssh
    echo "PermitRootLogin изменен на $new_value и служба SSH перезапущена."
}

# Функция для добавления пользователя в DenyUsers
add_user_to_denyusers() {
    echo "Введите имя пользователя для добавления в DenyUsers:"
    read -r deny_user

    # Добавление пользователя в DenyUsers
    sudo sed -i "/^DenyUsers/c\DenyUsers $deny_user" /etc/ssh/sshd_config

    # Перезапуск SSH сервиса
    sudo systemctl restart ssh
    echo "Пользователь $deny_user добавлен в DenyUsers и служба SSH перезапущена."
}

# Главное меню
while true; do
    echo "Выберите действие:"
    echo "1) Обновить список пакетов"
    echo "2) Установить обновления"
    echo "3) User для авторизации (no sudo)"
    echo "4) User для работы (sudo)"
    echo "5) Добавить в группы"
    echo "6) Сменить порт SSH"
    echo "7) Root изменить PermitRootLogin"
    echo "8) Добавить пользователя в DenyUsers"
    echo "9) Выход"

    read -r choice

    case $choice in
        1)
            update_list
            ;;
        2)
            update_and_upgrade
            ;;
        3)
            create_user "monitoring" "no"
            ;;
        4)
            create_user "admin" "yes"
            ;;
        5)
            while true; do
                echo "Выберите действие:"
                echo "1) sudo"
                echo "2) docker"
                echo "3) Главное меню"
                read -r group_choice
                case $group_choice in
                    1|2)
                        add_to_groups
                        ;;
                    3)
                        break
                        ;;
                    *)
                        echo "Неверный выбор. Пожалуйста, попробуйте снова."
                        ;;
                esac
            done
            ;;
        6)
            change_ssh_port
            ;;
        7)
            change_permit_root_login
            ;;
        8)
            add_user_to_denyusers
            ;;
        9)
            echo "Выход из программы."
            break
            ;;
        *)
            echo "Неверный выбор. Пожалуйста, попробуйте снова."
            ;;
    esac
    echo "----------------------------------------"
done
