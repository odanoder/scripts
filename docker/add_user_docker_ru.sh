#!/bin/bash

# Функция для добавления разделителя
print_separator() {
    echo "==============================================="
}

# Получаем текущее имя пользователя и сохраняем в переменную your_username
your_username=$(whoami)

# Выводим имя пользователя для подтверждения
print_separator
echo -e "\e[1;34mТекущий пользователь:\e[0m \e[1;32m$your_username\e[0m"
print_separator

# Добавляем пользователя в группу docker
echo -e "\e[1;33mДобавление пользователя $your_username в группу docker...\e[0m"
sudo usermod -aG docker "$your_username"

# Проверяем, что пользователь добавлен в группу docker
print_separator
echo -e "\e[1;32mУспешно:\e[0m Пользователь \e[1;32m$your_username\e[0m добавлен в группу \e[1;36mdocker\e[0m."
print_separator

# Предупреждение о необходимости перезагрузки
echo -e "\e[1;31mВНИМАНИЕ:\e[0m Для применения изменений выйдите из текущей сессии и войдите снова."
echo -e "Или выполните \e[1mnewgrp docker\e[0m для немедленного применения изменений."
print_separator
