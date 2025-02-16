#!/bin/bash

# Вывод заголовка
echo "Обновление списка пакетов..."
sudo apt update -y

# Установка базовых утилит
echo "Установка базовых утилит..."
sudo apt install -y coreutils nano wget curl tmux mc jq

# Установка утилит мониторинга
echo "Установка утилит мониторинга..."
sudo apt install -y htop

# Установка архиваторов и компрессии
echo "Установка архиваторов и компрессии..."
sudo apt install -y tar zip unzip lz4

# Установка дисковых утилит
echo "Установка дисковых утилит..."
sudo apt install -y tree ncdu nvme-cli

# Установка сетевых утилит
echo "Установка сетевых утилит..."
sudo apt install -y net-tools ufw netcat

# Установка пакетных утилит и инструментов разработки
echo "Установка инструментов разработки..."
sudo apt install -y pkg-config make cmake clang git build-essential

# Установка криптографических библиотек
echo "Установка криптографических библиотек..."
sudo apt install -y libssl-dev ca-certificates

# Установка cron
echo "Установка cron..."
sudo apt install -y cron
sudo systemctl enable cron
sudo systemctl start cron

# Вывод завершения установки
echo "Установка завершена!"

# Вывод завершения установки
echo "Установка завершена!"

# `coreutils` – набор базовых утилит (`ls`, `cat`, `rm`, `mv` и др.)  
# `nano` – простой текстовый редактор  
# `htop` – удобный мониторинг процессов  
# `wget` – загрузка файлов по HTTP/HTTPS/FTP  
# `curl` – работа с URL и HTTP-запросами  
# `tmux` – мультиплексор терминала  
# `mc` – файловый менеджер Midnight Commander  
# `jq` – обработка JSON в командной строке  
# `htop` – улучшенный аналог `top` с цветным интерфейсом 
# `tar` – работа с архивами `.tar`  
# `zip` – создание ZIP-архивов  
# `unzip` – распаковка ZIP-архивов  
# `lz4` – утилита сжатия данных  
# `tree` – показывает структуру каталогов в виде дерева  
# `pstree` – отображает дерево процессов  
# `ncdu` – анализатор дискового пространства  
# `nvme-cli` – утилита для управления NVMe-дисками 
# `net-tools` – инструменты для работы с сетью (`ifconfig`, `netstat` и др.)  
# `iptables` – настройка брандмауэра в Linux  
# `ufw` – удобный интерфейс для `iptables`  
# `netcat` (nc) – инструмент диагностики сети и передачи данных  
# `pkg-config` – управление зависимостями библиотек  
# `make` – автоматизация сборки программ  
# `cmake` – система сборки проектов  
# `clang` – компилятор C/C++ (альтернатива GCC)  
# `git` – система управления версиями  
# `build-essential` – метапакет с компиляторами и инструментами разработки 
# `libssl-dev` – заголовочные файлы для OpenSSL  
# `ca-certificates` – корневые сертификаты для работы HTTPS
