!/bin/bash

Colores vivos
BLUE='\033[1;34m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
MAGENTA='\033[1;95m'
NC='\033[0m'

Lista de DNS cubanos
DNS_SERVERS=("200.55.128.130" "200.55.128.140" "200.55.128.230" "200.55.128.250")
DOMINIO="madara"
USUARIO="madara"

clear

Cartel de bienvenida
echo -e "${MAGENTA}${NC}"
echo -e "${MAGENTA}   💻 Bienvenido a la script de Jakudoshy   ${NC}"
echo -e "${MAGENTA}${NC}"
echo ""
echo -e "${GREEN}📱 1) Conexión por Datos Móviles (DNS Cubanos)${NC}"
echo -e "${BLUE}📶 2) Conexión por WiFi (DNS Cubanos)         ${NC}"
echo -e "${YELLOW}❌ 3) Salir                                   ${NC}"
echo ""
read -p "Seleccione una opción: " opcion

case $opcion in
  1|2)
    for dns in "${DNS_SERVERS[@]}"; do
      clear
      echo -e "${BLUE}${NC}"
      echo -e "${BLUE}   🔌 Conectando al DNS de Jakudoshy...     ${NC}"
      echo -e "${BLUE}${NC}"
      echo ""
      echo -e "${YELLOW}🌐 Intentando conexión con: $dns:53${NC}"
      echo ""
      echo -e "${MAGENTA}⏳ Por favor espere...${NC}"
      iodine -f -r $dns $DOMINIO $USUARIO &
      sleep 7
      clear
      echo -e "${GREEN}${NC}"
      echo -e "${GREEN}   ✅ Estás conectado al DNS de Jakudoshy    ${NC}"
      echo -e "${GREEN}${NC}"
      echo ""
      echo -e "${BLUE}🔒 Túnel DNS activo con: $dns${NC}"
      echo -e "${YELLOW}🛑 Presiona Ctrl+C para desactivar.${NC}"
      wait
      break
    done
    ;;
  3)
    echo -e "${YELLOW}👋 Saliendo...${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}⚠️ Opción inválida${NC}"
    ;;