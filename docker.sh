#!/bin/bash

# Asegurarse de que el script se ejecuta en la raíz del proyecto
cd "$(dirname "$0")"

echo "[*] Buscando nuevas ramas en GitHub..."

# Backend
cd Backend
git fetch --all --prune --quiet
backend_branches=($(git branch -r | grep -v "\->" | sed 's| *origin/||'))
cd ..

echo ""
echo "=== SELECCIÓN DE RAMA PARA BACKEND ==="
PS3="Introduce el número de la rama para Backend: "
select backend_branch in "${backend_branches[@]}"; do
    if [[ -n "$backend_branch" ]]; then
        echo "-> Backend fijado en: $backend_branch"
        break
    else
        echo "Opción inválida. Inténtalo de nuevo."
    fi
done

# Frontend
cd Frontend
git fetch --all --prune --quiet
frontend_branches=($(git branch -r | grep -v "\->" | sed 's| *origin/||'))
cd ..

echo ""
echo "=== SELECCIÓN DE RAMA PARA FRONTEND ==="
PS3="Introduce el número de la rama para Frontend: "
select frontend_branch in "${frontend_branches[@]}"; do
    if [[ -n "$frontend_branch" ]]; then
        echo "-> Frontend fijado en: $frontend_branch"
        break
    else
        echo "Opción inválida. Inténtalo de nuevo."
    fi
done

echo ""
echo "[*] Cambiando a las ramas seleccionadas y descargando el código más reciente..."
cd Backend
git checkout "$backend_branch" --quiet
git pull origin "$backend_branch" --quiet
cd ..

cd Frontend
git checkout "$frontend_branch" --quiet
git pull origin "$frontend_branch" --quiet
cd ..

echo ""
if [[ "$backend_branch" == "main" && "$frontend_branch" == "main" ]]; then
    echo "[*] Ambas ramas son 'main'."
    echo "[*] Descargando imágenes pre-compiladas de GitHub Container Registry..."
    docker-compose pull
    echo "[*] Levantando servicios..."
    docker-compose up -d
else
    echo "[*] Se han detectado ramas distintas de 'main'."
    echo "[*] Descargando imágenes base..."
    docker-compose pull --quiet
    
    services_to_build=""
    if [[ "$backend_branch" != "main" ]]; then
        services_to_build="backend"
    fi
    if [[ "$frontend_branch" != "main" ]]; then
        services_to_build="$services_to_build frontend"
    fi
    
    echo "[*] Forzando compilación (build) local para los servicios modificados: $services_to_build"
    # shellcheck disable=SC2086
    docker-compose build $services_to_build
    echo "[*] Levantando todos los servicios..."
    docker-compose up -d
fi

echo ""
echo "[+] Despliegue completado con éxito."
