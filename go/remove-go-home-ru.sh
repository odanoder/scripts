#!/bin/bash

# Удаляем директорию Go с правами суперпользователя
sudo rm -rf "$HOME/go"

# Удаляем соответствующую строку из .bashrc
sed -i '/export PATH=\$PATH:$HOME\/go\/bin/d' "$HOME/.bashrc"

echo "Директория Go успешно удалена из домашней директории '${HOME}'."
