#!/bin/bash

# Определяем безпроводной интерфейс Wi-Fi

echo "Определяем безпроводной интерфейс Wi-Fi..."

WIRELESS_INTERFACE=$(iwctl device list | grep -o "wlan[0-9]\|wlp[0-9]s[0-9]")

if [ -n "$WIRELESS_INTERFACE" ]; then
    echo "Безпроводной интерфейс определен: $WIRELESS_INTERFACE"
else 
    echo "Безпроводной интерфейс не найден..."
fi    

# Проверяем блокировку wifi
echo "Проверяем блокировку Wi-FI"

if rfkill list wifi | grep -q "blocked: yes"; then
    echo "Wi-Fi заблокирован. Разблокируем..."
    rfkill unblock wifi
    echo "Wi-Fi Разблокирован..."
else 
    echo "Wi-Fi не заблокирован"
fi 
