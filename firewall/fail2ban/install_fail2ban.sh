#!/bin/bash

echo "Обновление списка пакетов и установка обновлений..."
sudo apt update && sudo apt upgrade -y

echo "Установка Fail2Ban..."
sudo apt install fail2ban -y

echo "Проверка статуса Fail2Ban..."
sudo systemctl status fail2ban | grep "Active:"

if sudo systemctl status fail2ban | grep -q "inactive (dead)"; then
    echo "Fail2Ban не запущен (inactive)."
elif sudo systemctl status fail2ban | grep -q "active (running)"; then
    echo "Fail2Ban запущен и работает (active)."
else
    echo "Fail2Ban запущен, но с ошибками."
fi

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
sudo systemctl status fail2ban | grep "Active:"
