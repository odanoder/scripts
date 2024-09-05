#!/bin/bash

# Обновление списка пакетов и установка обновлений
echo "Обновление списка пакетов и установка обновлений..."
sudo apt update && sudo apt upgrade -y

# Установка Fail2Ban
echo "Установка Fail2Ban..."
if sudo apt install fail2ban -y; then
    echo "Fail2Ban успешно установлен."
else
    echo "Ошибка при установке Fail2Ban."
    exit 1
fi

# Проверка статуса Fail2Ban
echo "Проверка статуса Fail2Ban..."
if sudo systemctl is-active --quiet fail2ban; then
    echo "Fail2Ban запущен и работает (active)."
else
    echo "Fail2Ban не запущен (inactive)."
fi

# Создание резервной копии конфигурационного файла
echo "Создание резервной копии конфигурационного файла..."
if [ -f /etc/fail2ban/jail.conf ]; then
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    echo "Файл /etc/fail2ban/jail.local успешно создан."
else
    echo "Ошибка: файл /etc/fail2ban/jail.conf не найден."
fi

# Дополнительное форматирование для выделения выводов
echo -e "\n\n###**********###"
echo "Проверка файлов конфигурации и статуса Fail2Ban:"

if [ -f /etc/fail2ban/jail.local ]; then
    echo "Файл /etc/fail2ban/jail.local существует."
else
    echo "Файл /etc/fail2ban/jail.local не найден."
fi

echo -e "\nПроверка статуса Fail2Ban..."
if sudo systemctl is-active --quiet fail2ban; then
    echo "Fail2Ban запущен и работает (active)."
else
    echo "Fail2Ban не запущен (inactive)."
fi
