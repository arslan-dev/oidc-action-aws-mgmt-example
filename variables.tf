variable "github_organization" {
  description = "The GitHub organization"
  type        = string
  default     = "arslan-dev"
}

variable "github_repo" {
  description = "The GitHub repository"
  type        = string
  default     = "oidc-action-aws-mgmt-terraform-example"
}

variable "github_branch" {
  description = "The GitHub branch"
  type        = string
  default     = "refs/heads/main"
}