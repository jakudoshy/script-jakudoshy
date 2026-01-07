#!/bin/bash
# Colores
R='\033[1;91m'
NC='\033[0;00m'
G='\033[1;92m'
M='\033[1;95m'
C='\033[1;96m'

# DNS
DNS_SERVER1="200.55.128.130"
DNS_SERVER2="200.55.128.140"
DNS_SERVER3="200.55.128.230"
DNS_SERVER4="200.55.128.250"
DOMINIO="dns.etecsafree.work.gd"

# Funciones Slipstream con timeout
Sliptream_c() {
    local dns_ip="$1"
    timeout 15 ./slipstream-client --tcp-listen-port=5201 \
        --resolver="${dns_ip}:53" --domain="$DOMINIO" \
        --keep-alive-interval=600 --congestion-control=cubic
}

# Animación hacker
animacion_hacker () {
    echo -ne "${C}⌛ Conectando"
    for i in {1..10}; do echo -ne " █"; sleep 0.1; done
    echo -e " ${G}✔${NC}"
}

# Menú post-conexión
menu_post_conexion () {
    dns_usado=$1
    clear
    echo -e "${G}+------------------------------+${NC}"
    echo -e "${G}| ✅ CONEXIÓN ESTABLECIDA      |${NC}"
    echo -e "${G}+------------------------------+${NC}"
    echo ""
    echo -e "${M}🌐 Conectado usando: ${dns_usado}${NC}"
    echo ""
    echo -e "${M}[1] 🔄 VOLVER AL MENU PRINCIPAL${NC}"
    echo -e "${R}[2] 📴 DESCONECTAR Y SALIR${NC}"
    echo -e "${R}[3] ⛓️ CERRAR TÚNEL (Ctrl+C)${NC}"
    echo ""
    read -p "👉 Seleccione una opción: " opcion_post
    case $opcion_post in
        1) bash $0 ;;
        2) echo -e "${R}📴 Desconectando...${NC}"; killall slipstream-client; exit 0 ;;
        3) echo -e "${R}⛓️ Para cerrar el túnel presiona Ctrl+C en la terminal.${NC}" ;;
        *) echo -e "${R}❌ OPCIÓN INVÁLIDA ❌${NC}" ;;
    esac
}

# Conexión DNS con limpieza y cartel fijo
dns_jakudoshy () {
    for dns_ip in $DNS_SERVER1 $DNS_SERVER2 $DNS_SERVER3 $DNS_SERVER4; do
        clear
        echo -e "${M}+------------------------------+${NC}"
        echo -e "${M}| 🚀 INICIANDO CONEXIÓN JAKUDOSHY |${NC}"
        echo -e "${M}+------------------------------+${NC}"
        echo ""
        echo -e "${C}🔎 Probando DNS: ${dns_ip}${NC}"
        echo ""
        animacion_hacker

        if Sliptream_c "$dns_ip"; then
            menu_post_conexion "DNS - $dns_ip"
            return
        else
            echo -e "${R}❌ Falló la conexión con ${dns_ip}${NC}"
            sleep 2
        fi
    done

    clear
    echo -e "${R}+------------------------------+${NC}"
    echo -e "${R}| ❌ NO SE CONECTÓ NINGUNA DNS |${NC}"
    echo -e "${R}+------------------------------+${NC}"
    echo ""
    sleep 2
    menu_reconexion
}

# Menú de reconexión
menu_reconexion () {
    clear
    echo -e "${R}+------------------------------+${NC}"
    echo -e "${R}| 🔄 MENU DE RECONEXIÓN        |${NC}"
    echo -e "${R}+------------------------------+${NC}"
    echo ""
    echo -e "${G}[1] 🔁 RECONECTAR${NC}"
    echo -e "${R}[2] ❌ SALIR${NC}"
    echo ""
    read -p "👉 Seleccione una opción: " reconect
    case $reconect in
        1) dns_jakudoshy ;;
        2) exit 0 ;;
        *) echo -e "${R}❌ OPCIÓN INVÁLIDA ❌${NC}" ;;
    esac
}

# Menú principal
clear
echo -e "${M}+------------------------------+${NC}"
echo -e "${M}| 🎉 BIENVENIDO JAKUDOSHY      |${NC}"
echo -e "${M}+------------------------------+${NC}"
echo ""
echo -e "${G}[1] 📱 CONECTAR CON DATOS MÓVIL${NC}"
echo -e "${G}[2] 📶 CONECTAR CON WIFI${NC}"
echo -e "${R}[3] ❌ SALIR${NC}"
echo ""
read -p "👉 Seleccione una opción: " opcion
case $opcion in 
    1) dns_jakudoshy ;;
    2) dns_jakudoshy ;;  # puedes poner otra función si quieres diferenciar WiFi
    3) exit 0 ;;
    *) echo -e "${R}❌ OPCIÓN INVÁLIDA ❌${NC}" ;;
esac