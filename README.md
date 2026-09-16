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

El archivo principal `docker-compose.yml` está configurado para **funcionar de forma universal en cualquier máquina (CPU por defecto)**, sin requerir hardware ni controladores específicos.

#### **ModoEstándar / CPU (Universal - Recomendado sin GPU):**
Funciona en cualquier ordenador portátil, servidor o máquina sin gráfica NVIDIA.

- **Con imágenes de producción (GHCR):**
  ```bash
  docker compose pull
  docker compose up -d
  ```
- **Compilando código local:**
  ```bash
  docker compose up -d --build
  ```

#### **Modo Aceleración por GPU (Opcional - NVIDIA GPU):**
Si la máquina dispone de una GPU NVIDIA y el paquete `nvidia-container-toolkit` instalado, se puede habilitar la aceleración hardware para el modelo de lenguaje de Ollama combinando el archivo `docker-compose.gpu.yml`:

- **Con imágenes de producción (GHCR):**
  ```bash
  docker compose pull
  docker compose -f docker-compose.yml -f docker-compose.gpu.yml up -d
  ```
- **Compilando código local:**
  ```bash
  docker compose -f docker-compose.yml -f docker-compose.gpu.yml up -d --build
  ```

### 3. Acceso
- **Frontend (Orquestador HUD):** [http://localhost](http://localhost)
- **Neo4j Browser:** [http://localhost:7474](http://localhost:7474)
- **Backend API:** Internamente en el puerto `8080`, aunque el Frontend se comunica con él a través del proxy `/api/`.
