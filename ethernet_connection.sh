#!/bin/bash

#Ищем проводной интерфейс
INTERFACE=$(ip link show | grep -oE "eth[0-9]|enp[0-9]+s[0-9]+" | head -n 1)
if [ -n "$INTERFACE" ]; then
    # Выводим имя интерфейса или пустую строку, если интерфейс не найден
    echo "Проводной интерфейс найден: $INTERFACE"

    # Проверка подключения к интернету через интерфейс
    echo "Проверка подключения к интернету..."
    if ping -I "$INTERFACE" -c 1 8.8.8.8 &> /dev/null; then
        echo "Проводной интерфейс $INTERFACE подключен к интернету."
        exit 0
    else
        echo "Проводной интерфейс $INTERFACE не подключен к интернету."
        exit 1
    fi
        
fi