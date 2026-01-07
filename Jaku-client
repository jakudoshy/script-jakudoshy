#!/bin/bash
# Colores
R='\033[1;91m'
NC='\033[0;00m'
G='\033[1;92m'
M='\033[1;95m'
C='\033[1;96m'

# Carpeta de logs
LOG_DIR="$HOME/.jakudoshy"
LOG_FILE="$LOG_DIR/jaku.log"
mkdir -p "$LOG_DIR"

# DNS Datos
DNS_DATOS=("200.55.128.130" "200.55.128.140" "200.55.128.230" "200.55.128.250")
# DNS WiFi
DNS_WIFI=("181.225.231.120" "181.225.231.110" "181.225.233.40" "181.225.233.30")

DOMINIO="dns.etecsafree.work.gd"

# Función limpiar procesos
clean_client() {
    pkill -f slipstream-client 2>/dev/null
    sleep 1
}

# Función Slipstream con logs y timeout
slipstream_c() {
    local dns_ip="$1"
    clean_client
    > "$LOG_FILE"
    timeout 15 ./slipstream-client --tcp-listen-port=5201 \
        --resolver="${dns_ip}:53" --domain="$DOMINIO" \
        --keep-alive-interval=600 --congestion-control=cubic \
        > >(tee -a "$LOG_FILE") 2>&1 &
    PID=$!

    # Esperar confirmación
    for i in {1..7}; do
        if grep -q "Connection confirmed" "$LOG_FILE"; then
            wait $PID
            return 0
        fi
        if grep -q "Connection closed" "$LOG_FILE"; then
            break
        fi
        sleep 1
    done

    clean_client
    return 1
}

# Animación fija de conexión
animacion_hacker () {
    echo -ne "${C}⌛ Conectando DNS...${NC}"
    for i in {1..10}; do 
        echo -ne " █"
        sleep 0.1
    done
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

# Conexión con lista de DNS
dns_connect () {
    local servers=("$@")
    for dns_ip in "${servers[@]}"; do
        clear
        echo -e "${M}+------------------------------+${NC}"
        echo -e "${M}| 🚀 INICIANDO CONEXIÓN JAKUDOSHY |${NC}"
        echo -e "${M}+------------------------------+${NC}"
        echo ""
        animacion_hacker

        if slipstream_c "$dns_ip"; then
            menu_post_conexion "DNS - $dns_ip"
            return
        fi
        # ❌ Si falla, no muestra nada y pasa al siguiente
    done

    # Si ninguno conecta, mensaje genérico
    clear
    echo -e "${R}+------------------------------+${NC}"
    echo -e "${R}| ❌ NO SE PUDO ESTABLECER CONEXIÓN |${NC}"
    echo -e "${R}+------------------------------+${NC}"
    echo ""
    sleep 2
    menu_reconexion "${servers[@]}"
}

# Menú de reconexión
menu_reconexion () {
    local servers=("$@")
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
        1) dns_connect "${servers[@]}" ;;
        2) exit 0 ;;
        *) echo -e "${R}❌ OPCIÓN INVÁLIDA ❌${NC}" ;;
    esac
}

# Detectar red activa
detect_network() {
    iface=$(ip route get 8.8.8.8 2>/dev/null | awk '{print $5}')
    if [[ "$iface" =~ ^wl ]]; then
        echo "WIFI"
    elif [[ "$iface" =~ ^rmnet ]] || [[ "$iface" =~ ^ccmni ]] || [[ "$iface" =~ ^pdp ]]; then
        echo "DATOS"
    else
        echo "DESCONOCIDO"
    fi
}

# Menú principal en bucle infinito
while true; do
    clear
    NET=$(detect_network)
    DATA_MARK="○"
    WIFI_MARK="○"
    [[ "$NET" == "DATOS" ]] && DATA_MARK="●"
    [[ "$NET" == "WIFI" ]] && WIFI_MARK="●"

    echo -e "${M}+------------------------------+${NC}"
    echo -e "${M}| 🎉 BIENVENIDO JAKUDOSHY      |${NC}"
    echo -e "${M}+------------------------------+${NC}"
    echo ""
    echo -e "${C}🔎 Red detectada: $NET${NC}"
    echo ""
    echo -e "${G}$DATA_MARK 1) 📱 CONECTAR CON DATOS MÓVIL${NC}"
    echo -e "${C}$WIFI_MARK 2) 📶 CONECTAR CON WIFI${NC}"
    echo -e "${R}  3) ❌ SALIR${NC}"
    echo ""
    read -p "👉 Seleccione una opción: " opcion
    case $opcion in 
        1) dns_connect "${DNS_DATOS[@]}" ;;
        2) dns_connect "${DNS_WIFI[@]}" ;;
        3) exit 0 ;;
        *) echo -e "${R}❌ OPCIÓN INVÁLIDA ❌${NC}" ;;
    esac
done