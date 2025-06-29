variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "region" {
  description = "Región donde desplegar los recursos"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "Nombre del bucket de Cloud Storage"
  type        = string
}

variable "topic_name" {
  description = "Nombre del tópico de Pub/Sub"
  type        = string
}

variable "sa_name" {
  description = "Nombre de la cuenta de servicio"
  type        = string
}

variable "sa_description" {
  description = "Descripción de la cuenta de servicio"
  type        = string
}

variable "gitlab_repo_url" {
  description = "URL del repositorio GitLab que contiene el código fuente de la Cloud Function"
  type        = string
}

variable "gitlab_branch" {
  description = "Branch o tag del repositorio GitLab a usar como fuente"
  type        = string
}

variable "function_name" {
  description = "Nombre de la Cloud Function"
  type        = string
}

variable "entry_point" {
  description = "Nombre del método dentro del archivo principal de la función"
  type        = string
}

variable "source_bucket" {
  description = "Nombre del bucket que contiene el archivo ZIP de la Cloud Function"
  type        = string
}

variable "source_archive_object" {
  description = "Nombre del archivo ZIP dentro del bucket que contiene la Cloud Function"
  type        = string
}

variable "bq_dataset_name" {
  description = "Nombre del dataset de BigQuery"
  type        = string
}

variable "bq_table_name" {
  description = "Nombre de la tabla de BigQuery"
  type        = string
}

variable "bq_table_schema_path" {
  description = "Ruta local al archivo JSON que define el esquema de la tabla"
  type        = string
}