#!/bin/bash

# Проверяем, установлен ли Go
if command -v go &>/dev/null; then
    # Проверяем наличие директории Go
    if [ -d "$HOME/go" ]; then
        # Удаляем директорию Go
        sudo rm -rf "$HOME/go"

        # Удаляем соответствующую строку из .bashrc
        sed -i '/export PATH=\$PATH:$HOME\/go\/bin/d' "$HOME/.bashrc"

        echo "Go успешно удален из домашней директории '${HOME}'."
    else
        echo "Директория Go не найдена в домашней директории '${HOME}'."
    fi
else
    echo "Go не найден в системе."
fi
