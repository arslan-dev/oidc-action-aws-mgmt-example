# AWS EC2 Instance Management GitHub Action

This project provides a GitHub Action and Terraform configuration example that allows you to start and stop an AWS EC2 instance manually from GitHub UI using OIDC to connect GitHub to AWS.

## Usage

1. Run `terraform apply`
2. Using terraform output, fill out these GitHub Secrets:

- AWS_ROLE_TO_ASSUME
- AWS_REGION
- AWS_INSTANCE_ID

3. Use the workflow UI to manage EC2 instance.
