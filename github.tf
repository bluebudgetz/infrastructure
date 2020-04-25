variable "github_token" {
  type = string
}

variable "dockerhub_access_token" {
  type = string
}

provider "github" {
  token        = var.github_token
  organization = "bluebudgetz"
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

resource "github_repository" "gate" {
  name                   = "gate"
  description            = "Bluebudgetz API gateway"
  private                = false
  has_issues             = true
  has_projects           = true
  has_wiki               = false
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_rebase_merge     = false
  delete_branch_on_merge = true
  has_downloads          = false
  topics                 = ["api", "go", "golang"]
}

resource "github_actions_secret" "gate_dockerhub_access_token" {
  repository      = "gate"
  secret_name     = "DOCKERHUB_ACCESS_TOKEN"
  plaintext_value = var.dockerhub_access_token
}
