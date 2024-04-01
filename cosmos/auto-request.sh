#!/bin/bash

echo "Для выхода из скрипта нажмите на клавиатуре CTRL C"
echo "Введите название бинарного файла (nodechain)"
read -p "Например: sided :" nodechain
read -p "Введите имя кошелька (NameWallet): " NameWallet
read -p "Введите сеть в которой работает єкосистема (chain-id), например side-testnet-3 : " chainid

echo "---------"
echo "Вы ввели:"
echo "Имя бинарного файла: $nodechain"
echo "Имя кошелька: $NameWallet"
echo "Имя кошелька: $chainid"

if [ -n "$nodechain" ] && [ -n "$NameWallet" ] && [ -n "$chainid" ]; then
  echo "Выберите один из вариантов (1, 2, 3):"
  echo "1. Отобразить баланс кошелька"
  echo "2. Забрать реварды"
  echo "3. Вариант 3"
  read -p "Введите номер выбранного варианта: " choice
else
echo -e "\033[31mОдна или обе переменные пустые\033[0m"
fi

case $choice in
  1)
    echo "Вы выбрали Вариант 1"
    "$nodechain" q bank balances "$("$nodechain" keys show "$NameWallet" -a)"
    ;;
  2)
    echo "Вы выбрали Вариант 2"
    "$nodechain" tx distribution withdraw-all-rewards --from "$NameWallet" --chain-id "$chainid" --gas-adjustment 1.4 --gas auto --gas-prices 0.005uside -y
    ;;
  3)
    echo "Вы выбрали Вариант 3"
    "$nodechain" tx distribution withdraw-rewards "$("$nodechain" keys show "$NameWallet" --bech val -a)" --from "$NameWallet" --fees 1000uside --commission -y
    ;;
  *)
    echo "Некорректный ввод. Пожалуйста, выберите один из предложенных вариантов."
    ;;
esac






#########
# ЦВЕТ #
########
#RED='\033[0;31m'
#NC='\033[0m' # No Color
#echo -e "${RED}Одна или обе переменные пустые${NC}"
