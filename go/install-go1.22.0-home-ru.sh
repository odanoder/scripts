#!/bin/bash

# Запрос версии у пользователя
read -p "Введите версию Go для установки (по умолчанию 1.22.0): " input_version

# Используем 1.21.6, если ничего не введено
version=${input_version:-1.22.0}

# Подготовка директории
mkdir -p $HOME/go
cd $HOME

# Загрузка и установка выбранной версии Go
wget "https://golang.org/dl/go$version.linux-amd64.tar.gz"
tar -C $HOME/ -xzf "go$version.linux-amd64.tar.gz"
rm "go$version.linux-amd64.tar.gz"

# Добавление пути к бинарникам в .bashrc
echo "export PATH=\$PATH:$HOME/go/bin" >> $HOME/.bashrc

# Обновление текущей сессии
source $HOME/.bashrc

# Вывод версии Go после установки
go version

# Сообщение о завершении
echo "Установка Go $version завершена."
