#!/bin/bash

#Устанавливаем шрифт setfont cyr-sun16
setfont cyr-sun16
clear
echo "Устанавили шрифт setfont cyr-sun16"

#Настрока сети...

echo "Определяем интерфейсы..."
ETH_INTERFACE=$(ip link show | grep -oE "eth[0-9]|enp[0-9]+s[0-9]+" | head -n 1)
WLAN_INTERFACE=$(iwctl device list | grep -o "wlan[0-9]\|wlp[0-9]s[0-9]")

NETWORK_NAME="RTK_49"

if [ -n "$ETH_INTERFACE" ]; then
    echo "Проверяем соединение с интернетом"
    PING_RESULT=$(ping -I "$ETH_INTERFACE" -c 1 8.8.8.8 &> /dev/null; echo $?)
    isConnected=$([ "$PING_RESULT" -eq 0 ] && echo true || echo false)
    if [ "$isConnected" == "false" ]; then
        echo "Проводной интерфейс не подключен к интернету."
    fi
fi

if [ "$isConnected" == "false" ]; then
    echo "Проводной интерфейс не подключен к интернету."
    if [ -z "$WLAN_INTERFACE" ]; then
        echo "Безпроводной интерфейс не найден..." 
    fi
fi

# Настройка wi-fi
echo "Определяем безпроводной интерфейс Wi-Fi..."

if [ -z "$WLAN_INTERFACE" ]; then
    echo "Безпроводной интерфейс не найден..."
    exit 1
fi    

echo "Проверяем блокировку Wi-FI"

if rfkill list wifi | grep -q "blocked: yes"; then
    echo "Wi-Fi заблокирован. Разблокируем..."
    rfkill unblock wifi
    echo "Wi-Fi Разблокирован..."
fi

echo "Сканируем доступные Wi-Fi сети..."
iwctl station "$WLAN_INTERFACE" scan

# Доступные сети
AVAILABLE_NETWORKS=$(iwctl station "$WLAN_INTERFACE" get-networks)

if echo "$AVAILABLE_NETWORKS" | grep -q "$NETWORK_NAME"; then
    echo "Сеть $NETWORK_NAME найдена."
fi

#echo "$(dirname "$0")/ethernet_connection.sh"

#ETH_INTERFACE=$(bash "$(dirname "$0")/eth_interface.sh")




