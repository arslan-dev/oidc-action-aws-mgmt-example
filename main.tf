terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
  }

  required_version = ">= 1.6.6"
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

resource "aws_instance" "example" {
  ami           = "ami-0faab6bdbac9486fb"
  instance_type = "t2.micro"
}

data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}

resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  thumbprint_list = [data.tls_certificate.github.certificates.0.sha1_fingerprint]
  client_id_list  = ["sts.amazonaws.com"]
}

data "aws_iam_policy_document" "github_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_organization}/${var.github_repo}:ref:refs/heads/${var.github_branch}"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "github_role" {
  name               = "github_role"
  assume_role_policy = data.aws_iam_policy_document.github_trust.json
}

data "aws_iam_policy_document" "ec2_permissions" {
  statement {
    actions   = ["ec2:StartInstances", "ec2:StopInstances"]
    effect    = "Allow"
    resources = [aws_instance.example.arn]
  }
}

resource "aws_iam_policy" "ec2_permissions" {
  name   = "ec2_permissions"
  policy = data.aws_iam_policy_document.ec2_permissions.json
}

resource "aws_iam_role_policy_attachment" "github_role_attachment" {
  role       = aws_iam_role.github_role.name
  policy_arn = aws_iam_policy.ec2_permissions.arn
}

output "github_role_arn" {
  value = aws_iam_role.github_role.arn
}

output "ec2_instance_id" {
  value = aws_instance.example.id
}

output "region" {
  value = var.aws_region
}