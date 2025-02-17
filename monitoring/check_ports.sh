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

# Проверка наличия аргументов
if [ "$#" -lt 1 ]; then
    echo "Использование: $0 <порт1> [<порт2> ...] или $0 <начало>:<конец>"
    exit 1
fi

# Перебор всех переданных аргументов
for arg in "$@"; do
    # Проверяем, является ли аргумент диапазоном портов
    if [[ "$arg" == *":"* ]]; then
        IFS=':' read -r start end <<< "$arg"
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
        # Проверяем, является ли аргумент числом
        if ! [[ "$arg" =~ ^[0-9]+$ ]]; then
            echo "Ошибка: порт должен быть числом."
            continue
        fi
        # Проверяем диапазон порта
        if (( arg < 1 || arg > 65535 )); then
            echo "Ошибка: порт должен быть в диапазоне от 1 до 65535."
            continue
        fi
        # Проверяем порт
        check_port "$arg"
    fi
done
