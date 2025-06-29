variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "sa_name" {
  description = "Nombre corto (account_id) de la cuenta de servicio"
  type        = string
}

variable "sa_description" {
  description = "Descripción para mostrar en consola"
  type        = string
}