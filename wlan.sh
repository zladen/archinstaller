#!/bin/bash

# Определяем беспроводной интерфейс Wi-Fi
echo "Определяем беспроводной интерфейс Wi-Fi..."
WLAN_INTERFACE=$(iwctl device list | grep -o "wlan[0-9]\|wlp[0-9]s[0-9]")

NETWORK_NAME="RTK_49"
PASSWORD="20081977"

if [ -z "$WLAN_INTERFACE" ]; then
    echo "Беспроводной интерфейс не найден..."
    exit 1
fi    

echo "Проверяем блокировку Wi-Fi"

if rfkill list wifi | grep -q "blocked: yes"; then
    echo "Wi-Fi заблокирован. Разблокируем..."
    rfkill unblock wifi
    echo "Wi-Fi разблокирован..."
fi

# Сканируем доступные Wi-Fi сети
echo "Сканируем доступные Wi-Fi сети..."
iwctl station "$WLAN_INTERFACE" scan
sleep 2  # Пауза для завершения сканирования

# Получаем список доступных сетей
AVAILABLE_NETWORKS=$(iwctl station "$WLAN_INTERFACE" get-networks)

if echo "$AVAILABLE_NETWORKS" | grep -q "$NETWORK_NAME"; then
    echo "Сеть $NETWORK_NAME найдена."

    # Подключаемся к сети
    iwctl --passphrase "$PASSWORD" station "$WLAN_INTERFACE" connect "$NETWORK_NAME"

    # Проверка подключения
    CONNECTION_STATUS=$(iwctl station "$WLAN_INTERFACE" show | grep -q "connected")

    if [ "$CONNECTION_STATUS" ]; then
        echo "Успешно подключено к сети $NETWORK_NAME."
    else
        echo "Не удалось подключиться к сети $NETWORK_NAME."
    fi
else
    echo "Сеть $NETWORK_NAME не найдена среди доступных сетей."
fi

