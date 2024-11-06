#!/bin/bash

#Ищем проводной интерфейс
echo "Определяем проводной интерфейс..."

WIRE_INTERFACE=$(ip link show | grep -oE "eth[0-9]|enp[0-9]+s[0-9]+" | head -n 1)
if [ -n "$WIRE_INTERFACE" ]; then
    # Выводим имя интерфейса или пустую строку, если интерфейс не найден
    echo "Проводной интерфейс определен: $WIRE_INTERFACE"

    # Проверка подключения к интернету через интерфейс
    echo "Проверяем подключения к интернету..."
    if ping -I "$WIRE_INTERFACE" -c 1 8.8.8.8 &> /dev/null; then
        echo "Проводной интерфейс $WIRE_INTERFACE подключен к интернету."
        exit 0
    else
        echo "Проводной интерфейс $WIRE_INTERFACE не подключен к интернету."
        exit 1
    fi
        
fi