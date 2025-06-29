output "bucket_name" {
  description = "Nombre final del bucket de almacenamiento creado en GCS"
  value       = module.storage.bucket_name
}

output "pubsub_topic" {
  description = "Nombre del tópico Pub/Sub creado para eventos del bucket"
  value       = module.pubsub.topic
}

output "service_account_email" {
  description = "Email de la cuenta de servicio utilizada por la Cloud Function"
  value       = module.service_account.email
}

output "cloud_function_name" {
  description = "Nombre de la Cloud Function desplegada"
  value       = module.cloud_function.name
}

output "bigquery_dataset_id" {
  description = "ID del dataset de BigQuery creado"
  value       = module.bigquery.dataset_id
}

output "bigquery_table_id" {
  description = "ID completo de la tabla creada en BigQuery"
  value       = module.bigquery.table_id
}