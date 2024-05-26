#!/bin/bash

# Установка базовых утилит
sudo apt install -y coreutils nano htop wget curl tmux

# Установка архиваторов
sudo apt install -y tar zip unzip lz4

# Установка дисковых утилит
sudo apt install -y tree pstree ncdu nvme-cli

# Установка сетевых утилит
sudo apt install -y net-tools iptables ufw

# Установка пакетных утилит
sudo apt install -y pkg-config make gcc git

# Установка пакетов для экосистемы Cosmos
sudo apt install -y build-essential libssl-dev libleveldb-dev jq
