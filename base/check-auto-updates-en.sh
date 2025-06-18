#!/bin/bash

# Colors
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
    echo -e "${GREEN}✔ $2: enabled${RESET}"
  else
    echo -e "${RED}✘ $2: disabled${RESET}"
  fi
}

# Detect Ubuntu version
UBUNTU_VERSION=$(lsb_release -rs)

divider
echo -e "${BOLD}Automatic Updates Check - Ubuntu $UBUNTU_VERSION${RESET}"
divider

# 1. Check unattended-upgrades service
section "1. unattended-upgrades (APT)"
UA_STATUS=$(systemctl is-enabled unattended-upgrades.service 2>/dev/null || echo "disabled")
UA_ACTIVE=$(systemctl is-active unattended-upgrades.service 2>/dev/null || echo "inactive")

check_result "$UA_STATUS" "Service is enabled"
check_result "$UA_ACTIVE" "Service is active"

# 2. Check APT timers
section "2. APT Timers"
APT_TIMER=$(systemctl is-enabled apt-daily.timer 2>/dev/null || echo "disabled")
APT_UPG_TIMER=$(systemctl is-enabled apt-daily-upgrade.timer 2>/dev/null || echo "disabled")

check_result "$APT_TIMER" "apt-daily.timer"
check_result "$APT_UPG_TIMER" "apt-daily-upgrade.timer"

# 3. APT Periodic config
section "3. APT Periodic Configuration"
grep -r "APT::Periodic" /etc/apt/apt.conf.d/ 2>/dev/null | while read -r line; do
  echo -e "${YELLOW}$line${RESET}"
done

# 4. Snap auto-refresh status
section "4. Snap Auto-Refresh"
if command -v snap &>/dev/null; then
  SNAP_HOLD=$(snap get system refresh.hold 2>/dev/null)
  SNAP_TIMER=$(snap get system refresh.timer 2>/dev/null)
  SNAP_RETAIN=$(snap get system refresh.retain 2>/dev/null)

  echo -e "${BOLD}refresh.hold:${RESET}   ${SNAP_HOLD:-(not set)}"
  echo -e "${BOLD}refresh.timer:${RESET}  ${SNAP_TIMER:-(default)}"
  echo -e "${BOLD}refresh.retain:${RESET} ${SNAP_RETAIN:-(default)}"
else
  echo -e "${RED}Snap is not installed on this system.${RESET}"
fi

# 5. Summary and recommendations
section "5. Summary & Recommendations"

if [[ "$UA_ACTIVE" == "active" ]] || [[ "$APT_TIMER" == "enabled" ]] || [[ "$APT_UPG_TIMER" == "enabled" ]]; then
  echo -e "${YELLOW}❗ Automatic APT updates are enabled.${RESET}"
else
  echo -e "${GREEN}✔ Automatic APT updates are disabled.${RESET}"
fi

if [[ -n "$SNAP_HOLD" && "$SNAP_HOLD" > "$(date -u +%Y-%m-%dT%H:%M:%SZ)" ]]; then
  echo -e "${GREEN}✔ Snap updates are postponed until ${SNAP_HOLD}.${RESET}"
else
  echo -e "${RED}✘ Snap may auto-update at any time.${RESET}"
fi

divider
