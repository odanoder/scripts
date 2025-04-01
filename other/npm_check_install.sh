#!/bin/bash

# Цвета
RED='\033[0;31m'
NC='\033[0m' # Сброс цвета

# Проверка наличия npm
if command -v npm &> /dev/null
then
    echo -e "\n${RED}npm установлен. Версия: $(npm -v)${NC}\n"
else
    echo "npm не найден. Устанавливаем..."
    sudo apt update && sudo apt install -y npm
    echo -e "\n${RED}npm установлен. Версия: $(npm -v)${NC}\n"
fi
