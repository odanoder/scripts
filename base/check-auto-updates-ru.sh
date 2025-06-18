#!/bin/bash

# Цвета
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BOLD="\e[1m"
RESET="\e[0m"

divider() {
  echo -e "${YELLOW}------------------------------------------------------------${RESET}"
}

section() {
  echo -e "\n${BOLD}${YELLOW}▶ $1${RESET}"
}

check_result() {
  if [[ "$1" == "enabled" || "$1" == "active" ]]; then
    echo -e "${GREEN}✔ $2: включено${RESET}"
  else
    echo -e "${RED}✘ $2: отключено${RESET}"
  fi
}

# Определение версии Ubuntu
UBUNTU_VERSION=$(lsb_release -rs)

divider
echo -e "${BOLD}Проверка автообновлений в Ubuntu $UBUNTU_VERSION${RESET}"
divider

# 1. Проверка службы unattended-upgrades
section "1. Служба unattended-upgrades (APT)"
UA_STATUS=$(systemctl is-enabled unattended-upgrades.service 2>/dev/null || echo "disabled")
UA_ACTIVE=$(systemctl is-active unattended-upgrades.service 2>/dev/null || echo "inactive")

check_result "$UA_STATUS" "Служба включена"
check_result "$UA_ACTIVE" "Служба активна"

# 2. Проверка таймеров APT
section "2. Таймеры APT"
APT_TIMER=$(systemctl is-enabled apt-daily.timer 2>/dev/null || echo "disabled")
APT_UPG_TIMER=$(systemctl is-enabled apt-daily-upgrade.timer 2>/dev/null || echo "disabled")

check_result "$APT_TIMER" "apt-daily.timer"
check_result "$APT_UPG_TIMER" "apt-daily-upgrade.timer"

# 3. Конфиги APT Periodic
section "3. Конфигурация APT (Periodic)"
grep -r "APT::Periodic" /etc/apt/apt.conf.d/ 2>/dev/null | while read -r line; do
  echo -e "${YELLOW}$line${RESET}"
done

# 4. Проверка Snap автообновлений
section "4. Snap auto-refresh"
if command -v snap &>/dev/null; then
  SNAP_HOLD=$(snap get system refresh.hold 2>/dev/null)
  SNAP_TIMER=$(snap get system refresh.timer 2>/dev/null)
  SNAP_RETAIN=$(snap get system refresh.retain 2>/dev/null)

  echo -e "${BOLD}refresh.hold:${RESET}   ${SNAP_HOLD:-(не задано)}"
  echo -e "${BOLD}refresh.timer:${RESET}  ${SNAP_TIMER:-(по умолчанию)}"
  echo -e "${BOLD}refresh.retain:${RESET} ${SNAP_RETAIN:-(по умолчанию)}"
else
  echo -e "${RED}Snap не установлен в системе.${RESET}"
fi

# 5. Общий вывод
section "5. Вывод и рекомендации"

if [[ "$UA_ACTIVE" == "active" ]] || [[ "$APT_TIMER" == "enabled" ]] || [[ "$APT_UPG_TIMER" == "enabled" ]]; then
  echo -e "${YELLOW}❗ Автоматические обновления APT включены.${RESET}"
else
  echo -e "${GREEN}✔ Автоматические обновления APT отключены.${RESET}"
fi

if [[ -n "$SNAP_HOLD" && "$SNAP_HOLD" > "$(date -u +%Y-%m-%dT%H:%M:%SZ)" ]]; then
  echo -e "${GREEN}✔ Snap-обновления отложены до ${SNAP_HOLD}.${RESET}"
else
  echo -e "${RED}✘ Snap-обновления могут происходить в любое время.${RESET}"
fi

divider
