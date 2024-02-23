#!/bin/bash

# Проверяем, установлен ли Go
if command -v go &>/dev/null; then
    # Удаляем директорию Go
    rm -rf "$HOME/go"

    # Очищаем соответствующую строку из .bashrc
    sed -i '/export PATH=\$PATH:$HOME\/go\/bin/d' "$HOME/.bashrc"

    echo "Go успешно удален из домашней директории'${HOME}'."
else
    echo "Go не найден в домашней директории '${HOME}'."
fi
