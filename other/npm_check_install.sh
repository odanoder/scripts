#!/bin/bash

# Проверка наличия npm
if command -v npm &> /dev/null
then
    echo "npm уже установлен. Версия: $(npm -v)"
else
    echo "npm не найден. Устанавливаем..."
    sudo apt update && sudo apt install -y npm
    echo "npm установлен. Версия: $(npm -v)"
fi
