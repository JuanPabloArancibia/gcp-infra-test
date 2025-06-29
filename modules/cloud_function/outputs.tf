output "name" {
  description = "Nombre de la función Cloud Function desplegada"
  value       = google_cloudfunctions2_function.default.name
}