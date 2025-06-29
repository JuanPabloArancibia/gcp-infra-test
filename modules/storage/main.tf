resource "google_storage_bucket" "main" {
  name     = var.bucket_name
  location = var.region
  project  = var.project_id

  uniform_bucket_level_access = true
  force_destroy               = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }
}

resource "google_storage_notification" "bucket_to_pubsub" {
  bucket         = google_storage_bucket.main.name
  topic          = var.pubsub_topic_id
  payload_format = "JSON_API_V1"
  event_types    = ["OBJECT_FINALIZE"]

  depends_on = [google_storage_bucket.main]
}