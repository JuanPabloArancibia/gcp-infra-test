output "topic_id" {
  description = "ID completo del tópico Pub/Sub, necesario para el bucket"
  value       = google_pubsub_topic.main.id
}

output "topic" {
  description = "Nombre corto del tópico (sin el path completo)"
  value       = google_pubsub_topic.main.name
}