#!/bin/bash

echo "Остановка службы Fail2Ban..."
sudo systemctl stop fail2ban.service

echo "Отключение автозапуска Fail2Ban..."
sudo systemctl disable fail2ban.service

echo "Удаление службы из systemd..."
sudo rm /lib/systemd/system/fail2ban.service

echo "Перезагрузка демонов systemd..."
sudo systemctl daemon-reload

echo "Удаление пакета Fail2Ban..."
sudo apt remove fail2ban -y

echo "Удаление остаточных файлов конфигурации и логов..."
sudo rm -rf /etc/fail2ban
sudo rm -rf /var/log/fail2ban
sudo rm -rf /var/lib/fail2ban

# ОПЦИОНАЛЬНЫЙ ШАГ: Удаление зависимостей
echo "Удалить пакеты зависимостей (если нужно)? (yes для удаления, ENTER для пропуска)"
read answer

if [ "$answer" == "yes" ]; then
    echo "Удаление ненужных пакетов..."
    sudo apt-get autoremove -y
else
    echo "Пропущен шаг удаления зависимостей."
fi

echo "Удаление fail2ban завершено."
