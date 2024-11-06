#!/bin/bash

#Устанавливаем шрифт setfont cyr-sun16
setfont cyr-sun16

clear

echo "Устанавили шрифт setfont cyr-sun16"

ETH_INTERFACE=$(/./ethernet_connection.sh)
export ETH_INTERFACE