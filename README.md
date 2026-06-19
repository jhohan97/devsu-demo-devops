
## Infraestructura y DevOps

### GitHub Actions - Pipeline CI/CD

Se ha configurado un pipeline automatizado de integración y entrega continua (CI/CD) en `.github/workflows/ci-cd.yml` que ejecuta los siguientes pasos:

#### 1. **Build, Test & Analyze**
- Ejecuta compilación con Maven
- Corre pruebas unitarias y genera reporte de cobertura con JaCoCo
- Publica resultados de pruebas
- Realiza análisis estático de código con SonarCloud
- Carga artefactos de cobertura

**Trigger:** Push a ramas `main` y `develop`, Pull Requests a `main`

#### 2. **Docker Build, Scan & Push**
- Construye imagen Docker multi-etapa optimizada
- Escanea la imagen con Trivy para vulnerabilidades (severidad CRITICAL, HIGH)
- Carga resultados de seguridad a GitHub Security
- Pushea la imagen a Docker Hub con tags basados en SHA del commit y rama

**Tags automáticos:**
- `sha-{commit_short}` (identificador único)
- `{branch_name}` (nombre de rama)
- `latest` (solo para rama main)

#### 3. **Deploy a Minikube**
- Aplica manifiestos de Kubernetes desde `k8s/manifests.yaml`
- Actualiza la imagen del deployment
- Espera a que finalice el rollout (timeout: 180s)
- Muestra URL de acceso a la aplicación

### Docker Compose

Archivo: `docker-compose.yml`

**Servicios:**
- **devsu-demo**: Aplicación Spring Boot en el puerto 8000

**Características:**
- Build multi-etapa optimizado desde Dockerfile
- Base de datos H2 con volumen persistente (`h2-data`)
- Variables de entorno configuradas (puerto, URL BD, credenciales)
- Health check automático cada 30 segundos
- Reinicio automático si se detiene

**Variables de entorno:**
```
PORT: 8000
NAME_DB: jdbc:h2:file:./data/testdb
USERNAME_DB: user
PASSWORD_DB: password
```

**Uso:**
```bash
# Construir e iniciar
docker-compose up -d

# Detener
docker-compose down

# Ver logs
docker-compose logs -f devsu-demo
```

### Dockerfile

Archivo: `dockerfile`

**Características:**
- **Stage 1 (Builder):** Maven 3.9.6 + Java 17, descarga dependencias y compila
- **Stage 2 (Runtime):** Eclipse Temurin 17 JRE Alpine (imagen ligera)
- Usuario no-root (`appuser`) por seguridad
- Volumen `/app/data` con permisos correctos
- Variables de entorno: `PORT`, `NAME_DB`, `USERNAME_DB`, `PASSWORD_DB`

**Ventajas:**
- Imagen final optimizada (~300MB vs 500MB+ sin multi-stage)
- Menor superficie de ataque (JRE en lugar de JDK)
- Compatible con Kubernetes y Docker Compose

### Kubernetes

Archivo: `k8s/manifests.yaml`

**Recursos configurados:**

#### 1. **ConfigMap** (`devsu-demo-config`)
Almacena variables de entorno:
```yaml
PORT: "8000"
NAME_DB: "jdbc:h2:file:/app/data/testdb"
USERNAME_DB: "user"
PASSWORD_DB: "password"
```

#### 2. **PersistentVolumeClaim** (`h2-pvc`)
- Almacenamiento persistente de 1Gi para la base de datos H2
- Modo: ReadWriteOnce

#### 3. **Deployment** (`devsu-demo-app`)
- 1 réplica
- Estrategia: Recreate (para BD con estado)
- **Recursos:**
  - Request: 512Mi RAM, 250m CPU
  - Limit: 1024Mi RAM, 500m CPU
- **Probes de salud:**
  - **Liveness:** Verifica `/api/actuator/health` cada 10s (falla tras 3 intentos)
  - **Readiness:** Verifica `/api/actuator/health` cada 5s (falla tras 3 intentos)
- **SecurityContext:** Ejecuta como usuario 1000 (appuser)

#### 4. **Service** (`devsu-demo-service`)
- Tipo: NodePort
- Puerto: 8000
- NodePort: 30080

**Acceso:** `http://<minikube-ip>:30080`

### Terraform - Infraestructura AWS

Directorio: `Terraform/`

**Estructura:**
```
Terraform/
├── modules/           # Módulos reutilizables
│   ├── cloudwatch/    # Dashboards y alarmas
│   ├── eks/           # Elastic Kubernetes Service
│   ├── iam/           # Políticas y roles
│   ├── kms/           # Cifrado de claves
│   ├── lb/            # Load Balancer
│   ├── networking/    # VPC, Subnets, Internet Gateway
│   ├── route53/       # DNS
│   ├── secret_manager/# Gestión de secretos
│   ├── security_group/# Grupos de seguridad
│   └── target_group/  # Grupos destino ALB/NLB
└── src/               # Configuraciones por ambiente
    ├── 0-dev/         # Ambiente DEV
    ├── 1-test/        # Ambiente TEST
    └── 2-prod/        # Ambiente PROD
```

**Características por Ambiente:**

Cada ambiente (dev, test, prod) incluye:
- Backend remoto (S3 + DynamoDB para bloqueos)
- VPC con subnets públicas y privadas
- Load Balancer (ALB)
- EKS cluster (Elastic Kubernetes Service)
- Route53 para DNS
- Secrets Manager para credenciales
- KMS para cifrado de datos
- CloudWatch para monitoreo
- IAM roles y políticas

**Requisitos previos:**
- AWS CLI configurado con credenciales válidas
- Bucket S3 para almacenar tfstate
- Permisos suficientes en AWS

**Pasos de despliegue:**

1. **Navegar al ambiente deseado:**
   ```bash
   cd Terraform/src/0-dev   # DEV
   # o cd Terraform/src/1-test   # TEST
   # o cd Terraform/src/2-prod   # PROD
   ```

2. **Inicializar Terraform:**
   ```bash
   terraform init
   ```

3. **Validar configuración:**
   ```bash
   terraform validate
   ```

4. **Revisar plan:**
   ```bash
   terraform plan
   ```

5. **Aplicar cambios:**
   ```bash
   terraform apply
   ```

**Variables importantes en `variables.tf`:**
- `environment`: Ambiente (dev, test, prod)
- `region`: Región AWS
- `vpc_cidr`: CIDR de la VPC
- `eks_version`: Versión de Kubernetes
- `node_group_size`: Tamaño de nodos (min, desired, max)

# Demo Devops Java

This is a simple application to be used in the technical test of DevOps.

## Getting Started

### Prerequisites

- Java Version 17
- Spring Boot 3.0.5
- Maven

### Installation

Clone this repo.

```bash
git clone https://bitbucket.org/devsu/demo-devops-java.git
```

### Database

The database is generated as a file in the main path when the project is first run, and its name is `test.mv.db`.

Consider giving access permissions to the file for proper functioning.

## Usage

To run tests you can use this command.

```bash
mvn clean test
```

To run locally the project you can use this command.

```bash
mvn spring-boot:run
```

Open http://127.0.0.1:8000/api/swagger-ui.html with your browser to see the result.

### Features

These services can perform,

#### Create User

To create a user, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: POST
```

```json
{
    "dni": "dni",
    "name": "name"
}
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "errors": [
        "error"
    ]
}
```

#### Get Users

To get all users, the endpoint **/api/users** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
[
    {
        "id": 1,
        "dni": "dni",
        "name": "name"
    }
]
```

#### Get User

To get an user, the endpoint **/api/users/<id>** must be consumed with the following parameters:

```bash
  Method: GET
```

If the response is successful, the service will return an HTTP Status 200 and a message with the following structure:

```json
{
    "id": 1,
    "dni": "dni",
    "name": "name"
}
```

If the user id does not exist, we will receive status 404 and the following message:

```json
{
    "errors": [
        "User not found: <id>"
    ]
}
```

If the response is unsuccessful, we will receive status 400 and the following message:

```json
{
    "errors": [
        "error"
    ]
}
```

## License

Copyright © 2023 Devsu. All rights reserved.
