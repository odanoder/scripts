#!/bin/bash

# Запрос пользователя о рабочей директории
read -p "Укажите рабочую директорию (например, .BABYLON/cosmovisor/genesis/bin): " WORKdir

# Проверка, указана ли рабочая директория
if [ -z "$WORKdir" ]; then
    echo "Вы не указали рабочую директорию. Скрипт завершен."
    exit 1
fi

# Запрос пользователя о имени бинарного файла
read -p "Введите имя бинарного файла (например, babylond): " NAMEbinary

# Проверка наличия бинарного файла и определение его пути
binary_path=$(which "$NAMEbinary")

if [ -z "$binary_path" ]; then
    echo "Ошибка: Бинарный файл $NAMEbinary не найден. Пожалуйста, убедитесь, что он скомпилирован и попробуйте снова."
    exit 1
fi

# Проверка установки Cosmovisor
if command -v cosmovisor &> /dev/null; then
    echo "Cosmovisor уже установлен. Прерываю выполнение скрипта."
    exit 1
fi

# Создание необходимых папок
mkdir -p "$WORKdir/cosmovisor/genesis/bin" || { echo "Ошибка при создании директорий. Прерываю выполнение скрипта."; exit 1; }
mkdir -p "$WORKdir/cosmovisor/upgrades"

# Проверка существования созданных директорий
if [ ! -d "$WORKdir/cosmovisor/genesis/bin" ] || [ ! -d "$WORKdir/cosmovisor/upgrades" ]; then
    echo "Ошибка: Директории не были созданы. Прерываю выполнение скрипта."
    exit 1
fi

# Установка Cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest

# Проверка успешности установки Cosmovisor
if [ $? -ne 0 ]; then
    echo "Ошибка при установке Cosmovisor. Пожалуйста, проверьте наличие Go в системе и повторите попытку."
    exit 1
fi

# Вывод информации о версии установленного Cosmovisor
cosmovisor_version=$(cosmovisor version)
echo "Установленная версия Cosmovisor: $cosmovisor_version"

# Копирование бинарного файла в указанную директорию
cp "$binary_path" "$WORKdir/cosmovisor/genesis/bin/"

# Вывод информации о бинарном файле
echo "Информация о бинарном файле:"
ls -l "$WORKdir/cosmovisor/genesis/bin/$NAMEbinary"
