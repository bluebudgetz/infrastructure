terraform {
  required_version = ">= 0.12.18"
  backend "gcs" {
    bucket = "bluebudgetz-terraform"
    prefix = "global"
  }
}
