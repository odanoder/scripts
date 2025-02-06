#!/bin/bash

# Определение цветов для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Вывод начального разделителя
echo "================"
echo "Проверка Docker и Docker Compose"
echo "================"

# Проверка наличия Docker
if command -v docker >/dev/null 2>&1; then
    DOCKER_VERSION=$(docker --version 2>/dev/null)
    echo -e "${GREEN}Docker установлен.${NC}"
    echo -e "${YELLOW}Версия Docker: ${DOCKER_VERSION}${NC}"
else
    echo -e "${RED}Docker НЕ установлен.${NC}"
    exit 1
fi

# Проверка наличия Docker Compose (старый способ: docker-compose)
if command -v docker-compose >/dev/null 2>&1; then
    COMPOSE_VERSION=$(docker-compose --version 2>/dev/null)
    echo -e "${GREEN}Docker Compose (docker-compose) установлен.${NC}"
    echo -e "${YELLOW}Версия Docker Compose (docker-compose): ${COMPOSE_VERSION}${NC}"
    OLD_DOCKER_COMPOSE=true
else
    echo -e "${RED}Docker Compose (docker-compose) НЕ установлен.${NC}"
    OLD_DOCKER_COMPOSE=false
fi

# Проверка доступности нового способа использования Docker Compose (docker compose)
if docker compose version >/dev/null 2>&1; then
    NEW_COMPOSE_VERSION=$(docker compose version 2>/dev/null | grep 'version' | awk '{print $2}')
    echo -e "${GREEN}Docker Compose (docker compose) доступен.${NC}"
    echo -e "${YELLOW}Версия Docker Compose (docker compose): ${NEW_COMPOSE_VERSION}${NC}"
    NEW_DOCKER_COMPOSE=true
else
    echo -e "${RED}Docker Compose (docker compose) НЕ доступен.${NC}"
    NEW_DOCKER_COMPOSE=false
fi

# Вывод конечного разделителя
echo ""
echo "================"
echo "Сводная информация:"
echo "================"

# Вывод информации о том, какой способ использования Docker Compose поддерживается
if [ "$NEW_DOCKER_COMPOSE" = true ] && [ "$OLD_DOCKER_COMPOSE" = true ]; then
    echo -e "${GREEN}Вы можете использовать как 'docker compose', так и 'docker-compose'.${NC}"
elif [ "$NEW_DOCKER_COMPOSE" = true ]; then
    echo -e "${GREEN}Вы можете использовать только 'docker compose'.${NC}"
elif [ "$OLD_DOCKER_COMPOSE" = true ]; then
    echo -e "${GREEN}Вы можете использовать только 'docker-compose'.${NC}"
else
    echo -e "${RED}Docker Compose не найден. Установите Docker Compose для использования.${NC}"
fi
