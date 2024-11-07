#!/bin/bash

# Сканируем доступные сети
echo "Сканируем доступные Wi-Fi сети..."
iwctl station "$INTERFACE" scan

# Проверяем наличие сети RTK_49
NETWORK_NAME="RTK_49"
AVAILABLE_NETWORKS=$(iwctl station "$INTERFACE" get-networks)

if echo "$AVAILABLE_NETWORKS" | grep -q "$NETWORK_NAME"; then
    echo "Сеть $NETWORK_NAME найдена."
    
    # Запрашиваем пароль у пользователя
    read -sp "Введите пароль для сети $NETWORK_NAME: " PASSWORD
    echo

    # Подключаемся к сети
    iwctl --passphrase "$PASSWORD" station "$INTERFACE" connect "$NETWORK_NAME"
    
    # Проверка подключения
    if iwctl station "$INTERFACE" show | grep -q "connected"; then
        echo "Успешно подключено к сети $NETWORK_NAME."
    else
        echo "Не удалось подключиться к сети $NETWORK_NAME. Проверьте пароль и настройки."
    fi
else
    echo "Сеть $NETWORK_NAME не найдена."
    echo "Доступные сети:"
    echo "$AVAILABLE_NETWORKS"
fi