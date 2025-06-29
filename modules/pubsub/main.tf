resource "google_pubsub_topic" "main" {
  name    = var.topic_name
  project = var.project_id
}

resource "google_pubsub_subscription" "dummy" {
  name    = "${var.topic_name}-dummy-sub"
  topic   = google_pubsub_topic.main.id
  project = var.project_id

  ack_deadline_seconds = 10

  # Como no vamos a usar esta subscripción realmente,
  # podemos dejarla tipo "push" a un endpoint dummy.
  push_config {
    push_endpoint = "https://example.com/push"
  }
}