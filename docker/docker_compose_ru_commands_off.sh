#!/bin/bash

# Функция для добавления разделителя
print_separator() {
    echo "=================================================="
}

# Функция для вывода базового гайда по командам Docker
show_docker_guide() {
    print_separator
    echo -e "\e[1;34mБазовый гайд по командам Docker\e[0m"
    print_separator
    echo -e "\e[1;36m1. Проверка версии Docker:\e[0m \e[1mdocker --version\e[0m"
    echo -e "\e[1;36m2. Список всех контейнеров:\e[0m \e[1mdocker ps -a\e[0m"
    echo -e "\e[1;36m3. Запуск контейнера:\e[0m \e[1mdocker start <container_id>\e[0m"
    echo -e "\e[1;36m4. Остановка контейнера:\e[0m \e[1mdocker stop <container_id>\e[0m"
    echo -e "\e[1;36m5. Удаление контейнера:\e[0m \e[1mdocker rm <container_id>\e[0m"
    echo -e "\e[1;36m6. Удаление образа:\e[0m \e[1mdocker rmi <image_id>\e[0m"
    echo -e "\e[1;36m7. Запуск контейнера из образа:\e[0m \e[1mdocker run -d <image_name>\e[0m"
    echo -e "\e[1;36m8. Просмотр логов контейнера:\e[0m \e[1mdocker logs <container_id>\e[0m"
    echo -e "\e[1;36m9. Подключение к контейнеру:\e[0m \e[1mdocker exec -it <container_id> /bin/bash\e[0m"
    echo -e "\e[1;36m10. Запуск Docker Compose:\e[0m \e[1mdocker compose up -d\e[0m"
    echo -e "\e[1;36m11. Остановка Docker Compose:\e[0m \e[1mdocker compose down\e[0m"
    print_separator
}

# Функция для выполнения установки Docker и Docker Compose
install_docker() {
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
}

# Основное меню выбора
echo -e "\e[1;34mВыберите опцию:\e[0m"
echo "1. Установить Docker и Docker Compose"
echo "2. Показать базовые команды Docker"
read -p "Введите номер опции (1 или 2): " option

# Обработка выбора пользователя
if [ "$option" == "1" ]; then
    install_docker
elif [ "$option" == "2" ]; then
    show_docker_guide
else
    echo -e "\e[1;31mНекорректный ввод. Запустите скрипт снова и выберите 1 или 2.\e[0m"
fi
