#!/bin/bash

echo "Обновление списка пакетов и установка обновлений..."
sudo apt update && sudo apt upgrade -y

echo "Установка Fail2Ban..."
sudo apt install fail2ban -y

echo "Проверка статуса Fail2Ban..."
sudo systemctl status fail2ban | grep "Active:"

if sudo systemctl status fail2ban | grep -q "inactive (dead)"; then
    echo "Fail2Ban не запущен (inactive)."
else
    echo "Fail2Ban запущен."
fi

echo "Создание резервной копии конфигурационного файла..."
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

if [ -f /etc/fail2ban/jail.local ]; then
    echo "Файл /etc/fail2ban/jail.local успешно создан."
else
    echo "Ошибка создания файла /etc/fail2ban/jail.local."
fi

echo "Установка Fail2Ban завершена."
