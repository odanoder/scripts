#!/bin/bash

# Проверка наличия Node.js
if command -v node &> /dev/null
then
    echo "Node.js уже установлен. Версия: $(node -v)"
else
    echo "Node.js не найден. Устанавливаем..."
    sudo apt update && sudo apt install -y nodejs
    echo "Node.js установлен. Версия: $(node -v)"
fi
