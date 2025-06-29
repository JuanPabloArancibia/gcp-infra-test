resource "google_cloudfunctions2_function" "default" {
  name        = var.function_name
  project     = var.project_id
  location    = var.region
  description = "Cloud Function desplegada desde ZIP en GCS con origen GitLab"

  build_config {
    runtime     = "python310"
    entry_point = var.entry_point

    # clonaremos el repo Gitlab como un objeto .zip en un bucket desde CI/CD
    source {
      storage_source {
        bucket = var.source_bucket
        object = var.source_archive_object
      }
    }
  }

  service_config {
    service_account_email = var.service_account_email
    available_memory      = "256M"
    timeout_seconds       = 60
    max_instance_count    = 1
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = "projects/${var.project_id}/topics/${var.topic_name}"
    retry_policy   = "RETRY_POLICY_RETRY"
  }
  # labels para auditoria
  labels = {
    repo   = replace(var.gitlab_repo_url, "https://", "")
    branch = var.gitlab_branch
  }
}