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
echo "TU_TOKEN_GH_PAT" | sudo docker login ghcr.io -u TU_USUARIO_GITHUB --password-stdin
```
*(Si el comando devuelve "Login Succeeded", estás listo).*

### 2. Arrancar la aplicación
Ejecuta el siguiente comando en la raíz del proyecto para descargar y arrancar las imágenes en segundo plano:

```bash
sudo docker-compose up -d
```

### 3. Acceso
- **Frontend (Orquestador HUD):** [http://localhost](http://localhost)
- **Neo4j Browser:** [http://localhost:7474](http://localhost:7474)
- **Backend API:** Internamente en el puerto `8080`, aunque el Frontend se comunica con él a través del proxy `/api/`.
