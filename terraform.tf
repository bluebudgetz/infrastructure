terraform {
  required_version = ">= 0.12.18"
  backend "gcs" {
    bucket = "bluebudgetz-terraform"
    prefix = "global"
  }
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

provider "github" {
  token        = var.github_token
  organization = "bluebudgetz"
}

data "google_organization" "kfirfamily" {
  provider = google-beta
  domain   = "kfirfamily.com"
}

resource "google_project" "prod" {
  provider        = google-beta
  project_id      = "bluebudgetz-prod"
  name            = "bluebudgetz-prod"
  billing_account = var.gcp_billing_account_id
}

resource "github_repository" "infrastructure" {
  name                   = "infrastructure"
  description            = "Bluebudgetz infrastructure"
  private                = false
  has_issues             = true
  has_projects           = true
  has_wiki               = false
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = false
  delete_branch_on_merge = true
  has_downloads          = false
  topics                 = ["infrastructure"]
}

variable "gcp_billing_account_id" {
  type = string
}

variable "github_token" {
  type = string
}
