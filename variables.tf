variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "aws_profile" {
  description = "Your AWS CLI SSO profile name"
  type        = string
}

variable "github_organization" {
  description = "Your GitHub organization or username"
  type        = string
}

variable "github_repo" {
  description = "Your GitHub repository name"
  type        = string
}

variable "github_branch" {
  description = "The GitHub branch"
  type        = string
}