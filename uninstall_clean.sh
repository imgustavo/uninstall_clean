#!/bin/bash

# Colores ANSI
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# Verificar si se ha pasado el nombre de la aplicación como argumento
if [ -z "$1" ]; then
    echo -e "${RED}Uso: $0 <nombre_de_la_aplicacion>${RESET}"
    exit 1
fi

# Nombre de la aplicación a desinstalar
APP_NAME=$1

# Paso 1: Desinstalar el paquete con apt, si existe
if dpkg -l | grep -q "$APP_NAME"; then
    echo -e "${YELLOW}Desinstalando $APP_NAME (APT)...${RESET}"
    sudo apt-get remove --purge "$APP_NAME" -y
    sudo apt-get autoremove --purge -y
    sudo apt-get autoclean
    echo -e "${GREEN}$APP_NAME desinstalado correctamente (APT).${RESET}"
else
    echo -e "${RED}$APP_NAME no está instalado como un paquete APT.${RESET}"
fi

# Paso 2: Desinstalar Flatpak, si existe
if flatpak list | grep -q "$APP_NAME"; then
    echo -e "${YELLOW}Desinstalando $APP_NAME (Flatpak)...${RESET}"
    flatpak uninstall --delete-data -y "$APP_NAME"
    echo -e "${GREEN}$APP_NAME desinstalado correctamente (Flatpak).${RESET}"
else
    echo -e "${RED}$APP_NAME no está instalado como Flatpak.${RESET}"
fi

# Paso 3: Eliminar configuraciones específicas
echo -e "${YELLOW}Eliminando configuraciones de la aplicación...${RESET}"
CONFIG_DIRS=(
    "$HOME/.config/$APP_NAME"
    "$HOME/.local/share/$APP_NAME"
    "/etc/$APP_NAME"
)

for DIR in "${CONFIG_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo -e "${YELLOW}Eliminando $DIR...${RESET}"
        rm -rf "$DIR"
        echo -e "${GREEN}$DIR eliminado.${RESET}"
    fi
done

# Paso 4: Eliminar archivos basura adicionales
echo -e "${YELLOW}Buscando y eliminando archivos relacionados en otras rutas...${RESET}"
ADDITIONAL_DIRS=(
    "$HOME/.local/share"
    "$HOME"
    "$HOME/.cache"
)

for DIR in "${ADDITIONAL_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo -e "${YELLOW}Revisando: $DIR${RESET}"
        find "$DIR" -name "*$APP_NAME*" -exec rm -rf {} + 2>/dev/null
        echo -e "${GREEN}Archivos relacionados en $DIR eliminados.${RESET}"
    else
        echo -e "${RED}Directorio no encontrado: $DIR${RESET}"
    fi
done

echo -e "${GREEN}Desinstalación y limpieza completadas para '$APP_NAME'.${RESET}"

