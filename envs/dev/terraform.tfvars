# Variables para ambiente dev

project_id = "proyecto-ejercicio-gcp-dev"
region     = "us-central1"

bucket_name = "bucket-ejercicio-terraform"
topic_name  = "topic-subidas-archivos"

sa_name        = "cloud-function-service-account"
sa_description = "Cuenta de servicio usada por la función Cloud Function"

gitlab_repo_url = "https://gitlab.com/usuario/repositorio-ejemplo"
gitlab_branch   = "dev"

function_name = "funcion-archivos-subidos"
entry_point   = "main"

source_bucket         = "bucket-codigo-funcion"
source_archive_object = "funcion.zip"

bq_dataset_name      = "dataset_usuarios" #ejemplo
bq_table_name        = "tabla_usuarios"   #ejemplo
bq_table_schema_path = "schemas/table.json"