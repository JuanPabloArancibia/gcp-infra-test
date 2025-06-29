variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "dataset_name" {
  description = "Nombre del dataset de BigQuery"
  type        = string
}

variable "table_name" {
  description = "Nombre de la tabla dentro del dataset"
  type        = string
}

variable "table_schema_path" {
  description = "Ruta local al archivo .json que define el esquema de la tabla"
  type        = string
}