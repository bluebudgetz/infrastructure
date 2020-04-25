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
  topics                 = ["infrastructure", "terraform"]
}

resource "github_branch_protection" "infrastructure-master" {
  repository             = github_repository.infrastructure.name
  branch                 = "master"
  enforce_admins         = false
  require_signed_commits = false

  required_status_checks {
    strict   = true
    contexts = ["Apply"]
  }
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

resource "github_branch_protection" "gate-master" {
  repository             = github_repository.gate.name
  branch                 = "master"
  enforce_admins         = false
  require_signed_commits = false

  required_status_checks {
    strict   = true
    contexts = ["Build", "coverage/coveralls"]
  }
}

resource "github_actions_secret" "gate_dockerhub_access_token" {
  repository      = "gate"
  secret_name     = "DOCKERHUB_ACCESS_TOKEN"
  plaintext_value = var.dockerhub_access_token
}
