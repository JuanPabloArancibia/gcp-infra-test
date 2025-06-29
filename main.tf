provider "google" {
  project = var.project_id
  region  = var.region
}

module "pubsub" {
  source     = "./modules/pubsub"
  project_id = var.project_id
  topic_name = var.topic_name
}

module "storage" {
  source          = "./modules/storage"
  project_id      = var.project_id
  region          = var.region
  bucket_name     = var.bucket_name
  pubsub_topic_id = module.pubsub.topic_id
}

module "service_account" {
  source         = "./modules/service_account"
  project_id     = var.project_id
  sa_name        = var.sa_name
  sa_description = var.sa_description
}

module "cloud_function" {
  source                = "./modules/cloud_function"
  project_id            = var.project_id
  region                = var.region
  service_account_email = module.service_account.email
  function_name         = var.function_name
  entry_point           = var.entry_point
  source_bucket         = var.source_bucket
  source_archive_object = var.source_archive_object
  gitlab_repo_url       = var.gitlab_repo_url
  gitlab_branch         = var.gitlab_branch
  topic_name            = var.topic_name
}

module "bigquery" {
  source            = "./modules/bigquery"
  project_id        = var.project_id
  dataset_name      = var.bq_dataset_name
  table_name        = var.bq_table_name
  table_schema_path = var.bq_table_schema_path
}