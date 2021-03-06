variable "gcp_billing_account_id" {
  type = string
}

provider "google" {
  version = "3.18.0"
  project = "bluebudgetz-prod"
  region  = "europe-west3"
  zone    = "europe-west3-b"
}

provider "google-beta" {
  version = "3.18.0"
  project = "bluebudgetz-prod"
  region  = "europe-west3"
  zone    = "europe-west3-b"
}

resource "google_project" "prod" {
  provider        = google-beta
  project_id      = "bluebudgetz-prod"
  name            = "bluebudgetz-prod"
  billing_account = var.gcp_billing_account_id
}

resource "google_project_service" "prod-iam" {
  project = google_project.prod.project_id
  service = "iam.googleapis.com"
}

resource "google_project_service" "prod-cloudresourcemanager" {
  project = google_project.prod.project_id
  service = "cloudresourcemanager.googleapis.com"
}
