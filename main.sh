#!/bin/bash


#Устанавливаем шрифт setfont cyr-sun16
setfont cyr-sun16

clear

echo "Устанавили шрифт setfont cyr-sun16"

#ETH_INTERFACE=$('./ethernet_connection.sh')
#echo SCRIPT_DIR="$(dirname "$0")"

#ETH_INTERFACE=$(source "./ethernet_connection.sh")
#Настрока соединения с сетью...

ETH_INTERFACE="$(source "$(dirname "$0")/ethernet_connection.sh")"

export ETH_INTERFACE