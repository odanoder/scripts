#!/bin/bash

# Проверяем наличие папки Go
if [ -d "$HOME/go" ]; then
    # Удаляем папку с правами суперпользователя
    sudo rm -rf "$HOME/go"
    
    # Удаляем соответствующую строку из .bashrc
    sudo sed -i '/export PATH=\$PATH:$HOME\/go\/bin/d' "$HOME/.bashrc"

    echo "Go успешно удален из домашней директории '${HOME}'."
else
    echo "Папка Go не найдена в домашней директории '${HOME}'."
fi
