resource "google_bigquery_dataset" "main" {
  dataset_id = var.dataset_name
  project    = var.project_id
  location   = "us"

  labels = {
    env = "dev"
  }
}

resource "google_bigquery_table" "main" {
  dataset_id = google_bigquery_dataset.main.dataset_id
  table_id   = var.table_name
  project    = var.project_id

  schema = file(var.table_schema_path)

  deletion_protection = false
}