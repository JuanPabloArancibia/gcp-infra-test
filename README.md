# Proyecto: Infraestructura Mínima en GCP con Terraform

Este proyecto define una infraestructura mínima en Google Cloud Platform utilizando Terraform (versión `>= 1.12.2`), diseñada para ambientes separados (dev, test, prod) y preparada para integrarse con pipelines CI/CD. **La ejecución sólo llega hasta `terraform plan`** (no se aplica).

## 📁 Estructura del Proyecto

```
.
├── composer/
│   └── dags/
│       └── data_validation_dag.py
├── envs/
│   └── dev/
│       └── terraform.tfvars
├── modules/
│   ├── bigquery/
│   ├── cloud_function/
│   ├── pubsub/
│   ├── service_account/
│   └── storage/
├── schemas/
│   └── table.json
├── .terraform-version
├── backend.tf
├── main.tf
├── outputs.tf
├── variables.tf
├── versions.tf
├── terraform.tfvars.example
├── requirements.txt
├── README.md
```

## 🔧 Instalación de dependencias

Este proyecto requiere Python (para el DAG de Composer) y Terraform:

1. Instalar Terraform `>= 1.12.2`. Si usas `tfenv`, se recomienda tener el archivo `.terraform-version` con el valor `1.12.2`.
2. Crear un entorno virtual (opcional pero recomendado):

```bash
python -m venv venv
source venv/bin/activate
```

3. Instalar los requirements del DAG:

```bash
pip install -r requirements.txt
```

## 🚀 Recursos desplegados

El proyecto define los siguientes recursos en GCP:

1. **Bucket de Cloud Storage** con evento hacia Pub/Sub (`OBJECT_FINALIZE`) y lifecycle de borrado a 30 días.
2. **Tópico y suscripción de Pub/Sub**.
3. **Cuenta de servicio** parametrizada, con permisos mínimos para Cloud Function.
4. **Cloud Function** desplegada desde un archivo ZIP ubicado en un bucket (no se descarga desde GitLab directamente).
5. **BigQuery Dataset y Tabla**, con esquema parametrizado desde archivo JSON.
6. **DAG en Composer** que valida la existencia de datos en la tabla.

## 📦 ZIP desde GitLab

La función Cloud Function se despliega utilizando un `source` del tipo `storage_source`, que espera que el ZIP ya esté en un bucket de GCS. Se asume que este ZIP fue subido manualmente o por CI/CD:

```hcl
source {
  storage_source {
    bucket = var.source_bucket
    object = var.source_archive_object
  }
}
```

## ✅ Validaciones y estilo

Para mantener buenas prácticas y consistencia en el código:

```bash
terraform validate           # Valida sintaxis y estructura del código Terraform
terraform fmt -recursive     # Aplica formato a todos los archivos .tf del proyecto
```

## ⚙️ Variables por ambiente

Cada ambiente (`dev`, `test`, `prod`) tiene su propio archivo `terraform.tfvars` dentro de `envs/<ambiente>`. Estos definen los valores de las variables requeridas, incluyendo `project_id`, `region`, `bucket_name`, `gitlab_branch`, entre otros.

Ejemplo de ejecución para `dev`:

```bash
terraform init -reconfigure
terraform plan -var-file="envs/dev/terraform.tfvars"
```

## 📂 Parámetros en los DAGs

Las variables utilizadas dentro de los DAGs (por ejemplo, `project_id`, `dataset`, `table`) **se asume que están configuradas como Variables de entorno en Composer**. Como alternativa más profesional, podrían ser inyectadas desde un pipeline de CI/CD.

## ⚠️ Supuestos

- **No** se crea el entorno Composer completo con Terraform, solo se incluye el DAG.
- El **código fuente de la función** se simula como ya existente en un bucket, listo para desplegar.
- **No se ejecuta `terraform apply`**, solo se llega a `terraform plan`.

## 📦 CI/CD (supuesto futuro)
- Se espera que el código fuente de la Cloud Function se descargue desde un repositorio GitLab como .zip a un bucket GCS.
- Las carpetas envs/dev, envs/test, envs/prod contienen configuraciones independientes por ambiente. La ejecución de los planes y despliegues debería orquestarse mediante un pipeline en **GitLab CI o GitHub Actions**.