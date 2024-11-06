#!/bin/bash

#Ищем проводной интерфейс
echo "Определяем проводной интерфейс..."
ETH_INTERFACE=$(ip link show | grep -oE "eth[0-9]|enp[0-9]+s[0-9]+" | head -n 1)
export ETH_INTERFACE

if [ -z "$ETH_INTERFACE" ]; then
    # Выводим имя интерфейса или пустую строку, если интерфейс не найден
    echo "Проводной интерфейс не определен"        
else 
    echo "Проверяем соединение с интернетом"
fi

PING_RESULT=$(ping -I "$ETH_INTERFACE" -c 1 8.8.8.8 &> /dev/null; echo $?)
isConnected=$([ "$PING_RESULT" -eq 0 ] && echo true || echo false)

if [ "$isConnected" == "false" ]; then
    echo "Проводной интерфейс не подключен к интернету."
    exit 1
fi