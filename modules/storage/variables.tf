variable "bucket_name" {
  description = "Nombre del bucket de GCS"
  type        = string
}

variable "region" {
  description = "Región del bucket"
  type        = string
}

variable "project_id" {
  description = "ID del proyecto de GCP"
  type        = string
}

variable "pubsub_topic_id" {
  description = "ID completo del tópico de Pub/Sub al que se envían los eventos"
  type        = string
}