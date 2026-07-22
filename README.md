# Orquestador
Orquestador con docker

# Clonar con
```bash
git clone --recurse-submodules https://github.com/TFM-UCM-Ciberseguridad-2026/Orquestador.git
```
o

```bash
git clone --recurse-submodules git@github.com:TFM-UCM-Ciberseguridad-2026/Orquestador.git
```

# Para hacer pull
```bash
git pull --recurse-submodules
```

# Uso y Despliegue con Docker

Para ejecutar la aplicación (Frontend, Backend y Base de Datos) de forma sencilla sin necesidad de instalar Go ni Node.js:

### 1. Iniciar sesión en GitHub Container Registry
Dado que las imágenes generadas por GitHub Actions son **privadas**, necesitas iniciar sesión en el registro de contenedores usando un **Personal Access Token (PAT)** de GitHub (con permisos `read:packages`).

```bash
echo "TU_TOKEN_GH_PAT" | docker login ghcr.io -u TU_USUARIO_GITHUB --password-stdin
```
*(Si el comando devuelve "Login Succeeded", estás listo).*

### 2. Arrancar la aplicación
Dependiendo de lo que quieras conseguir en esa primera ejecución (o en ejecuciones posteriores), debes elegir tu comando:

**Si quieres que descargue TODO de internet (versión de producción):**
Debes forzar la descarga de tus repositorios antes de levantar el entorno, de lo contrario podría priorizar construir tus carpetas locales por defecto. Esta es la opción ideal si no quieres modificar código.

```bash
docker-compose pull
docker-compose up -d
```

**Si quieres empezar trabajando con tu código local:**
Ejecuta el comando forzando el *build*. Docker Compose construirá las imágenes a partir del código fuente actual en las carpetas `Backend` y `Frontend` y las ejecutará.

```bash
docker-compose up -d --build
```


### 3. Acceso
- **Frontend (Orquestador HUD):** [http://localhost](http://localhost)
- **Neo4j Browser:** [http://localhost:7474](http://localhost:7474)
- **Backend API:** Internamente en el puerto `8080`, aunque el Frontend se comunica con él a través del proxy `/api/`.
