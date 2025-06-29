output "bucket_name" {
  description = "Nombre del bucket creado"
  value       = google_storage_bucket.main.name
}

output "bucket_self_link" {
  description = "Link del bucket creado"
  value       = google_storage_bucket.main.self_link
}