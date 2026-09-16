# HEIMDALL // Orquestador de Ciberseguridad

## Clonado del Repositorio y Submódulos

Por defecto, los submódulos (`BBDD`, `Backend`, `Frontend`) están configurados en `.gitmodules` mediante **HTTPS** (`https://github.com/...`) para permitir el clonado público sin necesidad de configurar llaves SSH.

### Clonar con HTTPS (Recomendado):
```bash
git clone --recurse-submodules https://github.com/TFM-UCM-Ciberseguridad-2026/Orquestador.git
```

### Si prefieres clonar mediante SSH:
```bash
git clone --recurse-submodules git@github.com:TFM-UCM-Ciberseguridad-2026/Orquestador.git
```

### Actualizar o cambiar URLs de submódulos (de SSH a HTTPS o viceversa):
Si habías clonado previamente con SSH y deseas cambiar los submódulos a HTTPS:
```bash
git submodule sync
git submodule update --init --recursive
```

---

## Configuración de Variables de Entorno (`.env.example`)

Antes de iniciar la aplicación localmente o compilar el Backend, crea una copia del archivo `.env.example` renombrándola a `.env`:

```bash
cp .env.example .env
```

### Explicación de las variables en `.env`:

| Variable | Descripción | Valor por Defecto / Ejemplo |
| :--- | :--- | :--- |
| `PORT` | Puerto HTTP donde escucha el API Backend en Go. | `8080` |
| `ENV` | Entorno de ejecución (`development` o `production`). | `development` |
| `NEO4J_URI` | URI de conexión a la base de datos Neo4j (Bolt/Docker). | `bolt://localhost:7687` |
| `NEO4J_USER` | Usuario administrador de Neo4j. | `neo4j` |
| `NEO4J_PASSWORD` | Contraseña de autenticación de Neo4j. | `password` |
| `NVD_API_KEY` | Clave API opcional de NIST NVD (acelera los escaneos de CVEs). | *(opcional)* |
| `NVD_BASE_URL` | Endpoint oficial de la API de NVD v2.0. | `https://services.nvd.nist.gov/rest/json/cves/2.0` |
| `NVD_API_TIMEOUT` | Tiempo límite en segundos para peticiones NVD. | `90` |
| `OLLAMA_HOST` | URL del servicio Ollama (LLM local). | `http://localhost:11434` |
| `OLLAMA_MODEL` | Modelo de lenguaje local a utilizar. | `gemma4:e4b` |
| `DOCKER_HUB_USER` | Usuario de Docker Hub para análisis de imágenes con Docker Scout. | `tu_usuario` |
| `DOCKER_HUB_TOKEN` | Token de acceso (PAT de solo lectura) en Docker Hub. | `dckr_pat_...` |

---

# Uso y Despliegue con Docker

Para ejecutar la aplicación (Frontend, Backend, Ollama y Base de Datos Neo4j) de forma sencilla sin necesidad de instalar Go ni Node.js:

### 1. Arrancar la aplicación

El archivo principal `docker-compose.yml` está configurado para **funcionar de forma universal en cualquier máquina (CPU por defecto)**, sin requerir hardware ni controladores específicos.

#### **Modo Estándar / CPU (Universal - Recomendado sin GPU):**
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

### 2. Acceso
- **Frontend (Orquestador HUD):** [http://localhost](http://localhost)
- **Neo4j Browser:** [http://localhost:7474](http://localhost:7474)
- **Backend API:** Internamente en el puerto `8080`, aunque el Frontend se comunica con él a través del proxy `/api/`.
