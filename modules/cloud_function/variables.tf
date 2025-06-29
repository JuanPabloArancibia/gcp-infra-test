variable "project_id" {
  description = "ID del proyecto en GCP"
  type        = string
}

variable "region" {
  description = "Región donde se desplegará la función"
  type        = string
}

variable "function_name" {
  description = "Nombre de la Cloud Function"
  type        = string
}

variable "entry_point" {
  description = "Nombre del método handler dentro del archivo principal"
  type        = string
}

variable "source_bucket" {
  description = "Bucket donde se encuentra el archivo .zip de la función"
  type        = string
}

variable "source_archive_object" {
  description = "Nombre del archivo ZIP dentro del bucket"
  type        = string
}

variable "service_account_email" {
  description = "Cuenta de servicio usada por la función"
  type        = string
}

variable "gitlab_repo_url" {
  description = "URL del repositorio GitLab (solo usado como label)"
  type        = string
}

variable "gitlab_branch" {
  description = "Branch o tag del repositorio GitLab (solo usado como label)"
  type        = string
}

variable "topic_name" {
  description = "Nombre del tópico Pub/Sub que dispara la función"
  type        = string
}