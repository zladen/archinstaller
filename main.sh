#!/bin/bash


#Устанавливаем шрифт setfont cyr-sun16
setfont cyr-sun16

clear

echo "Устанавили шрифт setfont cyr-sun16"

#Настрока соединения с сетью...

#echo "$(dirname "$0")/ethernet_connection.sh"

ETH_INTERFACE=$(bash "$(dirname "$0")/ethernet_connection.sh")
echo "$ETH_INTERFACE"