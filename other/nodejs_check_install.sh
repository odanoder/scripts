#!/bin/bash

# Цвета
RED='\033[0;31m'
NC='\033[0m' # Сброс цвета

# Проверка наличия Node.js
if command -v node &> /dev/null
then
    echo "________________________________________________________"
    echo -e "\n${RED}Node.js установлен. Версия: $(node -v)${NC}\n"
    echo "________________________________________________________"
else
    echo "___________________________________"
    echo "Node.js не найден. Устанавливаем..."
    echo "___________________________________"
    sudo apt update && sudo apt install -y nodejs
    echo "________________________________________________________"
    echo -e "\n${RED}Node.js установлен. Версия: $(node -v)${NC}\n"
    echo "________________________________________________________"
fi
