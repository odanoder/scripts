#!/bin/bash

install_rust() {
    echo "Устанавливаем Rust..."
    sudo apt update -y
    sudo apt install curl make clang pkg-config libssl-dev build-essential git mc jq unzip wget -y
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source $HOME/.cargo/env
    echo "Rust установлен."
}

update_rust() {
    echo "Обновляем Rust..."
    rustup update
    echo "Rust успешно обновлен."
}

show_rust_version() {
    echo "Текущая версия Rust:"
    rustc --version
}

while true; do
    echo "Выберите действие:"
    echo "1) Установить Rust"
    echo "2) Обновить Rust"
    echo "3) Показать текущую версию Rust"
    echo "0) Выйти из скрипта"
    read -p "Введите номер пункта: " choice

    case $choice in
        1) install_rust ;;
        2) update_rust ;;
        3) show_rust_version ;;
        0) echo "Выход из скрипта."; exit 0 ;;
        *) echo "Неверный выбор! Попробуйте снова." ;;
    esac
    echo ""
done
