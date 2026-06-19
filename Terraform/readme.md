├── main.tf            # Definición principal de recursos y orquestación de módulos
├── variables.tf       # Definición de variables globales
├── outputs.tf         # Salidas del despliegue
├── modules/           # Módulos reutilizables (VPC, RDS, Security Groups)
├── src/               # Se encuentra la configuracion de cada uno de los modulos
|   ├─ 0-dev           # Se encuentra la configuracion para la infra en ambiente DEV
|   ├─ 1-test            # Se encuentra la configuracion para la infra en ambiente TEST
|   ├─ 2-prod            # Se encuentra la configuracion para la infra en ambiente PROD
```

## Instrucciones de Ejecución

Siga estos pasos para desplegar la infraestructura:

NOTA: Partiremos desde el Supuesto de que ya se tiene logueada la cuenta de AWS en la terminal.

1.  **Seteo de datos para el TfState**
    Coloca en los archivos de backend los datos referentes del bucket donde se cuardara el tfstate
        bucket = "devsu-terraform-state"
        key    = "0-dev/terraform.tfstate"

2.  **Inicializar el directorio:**
    Descarga los proveedores necesarios y prepara el backend.
    ```bash
    terraform init
    ```

3.  **Validar la configuración:**
    Verifica que la sintaxis sea correcta.
    ```bash
    terraform validate

4.  **Planear la configuración:**
    Crea una lista de los recursos a crear.
    ```bash
    terraform plan

5.  **Aplica la configuración:**
    Crea los recursos listados en el plan.
    ```bash
    terraform apply
    