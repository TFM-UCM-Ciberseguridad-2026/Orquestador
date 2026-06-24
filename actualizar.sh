#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"
echo -e "${YELLOW}[*] Realizando un pull de seguridad...${RESET}"

git pull --recurse-submodules

echo -e "${YELLOW}[*] Buscando actualizaciones en Backend, Frontend y BBDD...${RESET}"

git submodule foreach 'git checkout main && git pull origin main'

if [[ -z $(git status --porcelain) ]]; then
    echo -e "${GREEN}[+] Todos los submódulos están al día. No hay nada que subir al Orquestador.${RESET}"
    exit 0
fi

echo -e "${YELLOW}[*] Nuevos commits detectados. Preparando la integración...${RESET}"

git add .

FECHA=$(date +"%Y-%m-%d %H:%M")
git commit -m "chore: actualización de submódulos ($FECHA)" > /dev/null

echo -e "${YELLOW}[*] Subiendo la nueva versión a GitHub...${RESET}"

git push origin main

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] ¡Orquestador actualizado y subido con éxito! El equipo ya puede descargarlo.${RESET}"
else
    echo -e "${RED}[-] Error: No se pudo subir a GitHub. Revisa tu conexión o permisos.${RESET}"
fi
