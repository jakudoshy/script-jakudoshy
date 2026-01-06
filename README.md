#!/bin/bash

while true; do
    clear
    echo "=============================="
    echo "      MENU DE TERMUX"
    echo "=============================="
    echo "1) Actualizar Termux"
    echo "2) Configurar DNS de ETECSA"
    echo "3) Mostrar IP"
    echo "4) Salir"
    echo "=============================="
    read -p "Elige una opción: " opcion

    case $opcion in
        1)
            echo "Actualizando Termux..."
            pkg update && pkg upgrade -y
            read -p "Presiona ENTER para continuar..."
            ;;
        2)
            echo "Configurando DNS de ETECSA..."
            mkdir -p $PREFIX/etc
            cp $PREFIX/etc/resolv.conf $PREFIX/etc/resolv.conf.bak 2>/dev/null

            cat <<EOF > $PREFIX/etc/resolv.conf
nameserver 200.55.128.250
nameserver 200.55.128.251
EOF

            echo "DNS configuradas correctamente."
            read -p "Presiona ENTER para continuar..."
            ;;
        3)
            echo "Tu IP actual es:"
            curl ifconfig.me
            echo ""
            read -p "Presiona ENTER para continuar..."
            ;;
        4)
            echo "Saliendo del menú..."
            exit 0
            ;;
        *)
            echo "Opción inválida."
            read -p "Presiona ENTER para continuar..."
            ;;
    esac
done