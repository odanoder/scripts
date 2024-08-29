#!/bin/bash

# Запрос имени пользователя
read -p "Введите имя нового пользователя: " username

# Создание нового пользователя
sudo adduser "$username"

# Подтверждение добавления в группы
read -p "Создание пользователя завершено. Хотите продолжить добавление пользователя в группы? (y/n): " continue_choice

if [[ "$continue_choice" =~ ^[yY]$ ]]; then
    # Запрос групп для добавления
    echo "Выберите группы, в которые нужно добавить пользователя:"
    echo "1) sudo"
    echo "2) docker"
    read -p "Введите номера групп через пробел (например, 1 2): " -a groups

    # Обработка выбранных групп
    for group in "${groups[@]}"; do
        case $group in
            1)
                sudo usermod -aG sudo "$username"
                echo "Пользователь $username добавлен в группу sudo."
                ;;
            2)
                sudo usermod -aG docker "$username"
                echo "Пользователь $username добавлен в группу docker."
                ;;
            *)
                echo "Некорректный выбор: $group"
                ;;
        esac
    done

    # Проверка добавленности в группы
    echo "Проверка добавленности пользователя $username в группы:"
    groups_output=$(groups "$username")
    echo "$groups_output"

    # Получение информации о пользователе
    home_dir=$(eval echo ~$username)
    user_groups=$(id -Gn "$username" | tr ' ' ',')

    # Вывод информации
    echo "Информация о пользователе:"
    echo "Имя пользователя: $username"
    echo "Домашний каталог: $home_dir"
    echo "Группы: $user_groups"
else
    echo "Добавление пользователя в группы отменено."
fi

echo "Процесс завершен."
