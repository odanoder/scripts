#!/bin/bash

# Функция для проверки занятости порта
check_port() {
    local port=$1
    if command -v netstat &> /dev/null; then
        # Если netstat доступен
        if netstat -tuln | grep -q ":$port\b"; then
            echo "Порт $port занят."
        else
            echo "Порт $port свободен."
        fi
    elif command -v ss &> /dev/null; then
        # Если ss доступен
        if ss -tuln | grep -q ":$port\b"; then
            echo "Порт $port занят."
        else
            echo "Порт $port свободен."
        fi
    else
        echo "Не найдены утилиты netstat или ss для проверки портов."
        exit 1
    fi
}

# Интерактивный ввод портов или диапазона
while true; do
    echo "Введите порт или диапазон портов (например, 80 или 1000:2000), или 'q' для выхода:"
    read input

    # Проверка на выход из скрипта
    if [[ "$input" == "q" || "$input" == "Q" ]]; then
        echo "Выход из программы."
        exit 0
    fi

    # Проверяем, является ли входной параметр диапазоном портов
    if [[ "$input" == *":"* ]]; then
        IFS=':' read -r start end <<< "$input"
        # Проверяем, что начало и конец диапазона являются числами
        if ! [[ "$start" =~ ^[0-9]+$ && "$end" =~ ^[0-9]+$ ]]; then
            echo "Ошибка: границы диапазона должны быть числами."
            continue
        fi
        # Проверяем корректность диапазона
        if (( start < 1 || start > 65535 || end < 1 || end > 65535 || start > end )); then
            echo "Ошибка: диапазон должен быть в пределах 1-65535 и начальный порт <= конечному."
            continue
        fi
        # Проверяем каждый порт в диапазоне
        for (( port=start; port<=end; port++ )); do
            check_port "$port"
        done
    else
        # Проверяем, является ли входной параметр числом
        if ! [[ "$input" =~ ^[0-9]+$ ]]; then
            echo "Ошибка: порт должен быть числом."
            continue
        fi
        # Проверяем диапазон порта
        if (( input < 1 || input > 65535 )); then
            echo "Ошибка: порт должен быть в диапазоне от 1 до 65535."
            continue
        fi
        # Проверяем порт
        check_port "$input"
    fi
done
