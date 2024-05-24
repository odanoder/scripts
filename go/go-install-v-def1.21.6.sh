#!/bin/bash

# Ask user for the Go version
# Запрос версии у пользователя
echo "Enter the Go version to install"
echo "Введите версию Go для установки"
read -p "default is 1.21.6: " input_version

# Use 1.21.6 if nothing is entered
# Используем 1.21.6, если ничего не введено
version=${input_version:-1.21.6}

# Prepare directory
# Подготовка директории
mkdir -p $HOME/go
cd $HOME

# Download and install the selected Go version
# Загрузка и установка выбранной версии Go
wget "https://golang.org/dl/go$version.linux-amd64.tar.gz"
tar -C $HOME/ -xzf "go$version.linux-amd64.tar.gz"
rm "go$version.linux-amd64.tar.gz"

# Add the path to binaries in .bashrc
# Добавление пути к бинарникам в .bashrc
echo "export PATH=\$PATH:$HOME/go/bin" >> $HOME/.bashrc

# Update the current session
# Обновление текущей сессии
source $HOME/.bashrc

# Display the Go version after installation
go version

# Completion message
# Сообщение о завершении
echo "Установка Go $version завершена."
echo "Go $version installation completed."
