# AWS EC2 Instance Management GitHub Action

This project provides a GitHub Action and Terraform configuration example that allows you to start and stop an AWS EC2 instance manually from GitHub UI using OIDC to connect GitHub to AWS.

## Usage

1. Fork the repository
2. Run `terraform init && terraform apply` and provide necessary values
3. Using terraform output, fill out these GitHub Secrets (Repository Settings -> Secrets and variables):

- AWS_ROLE_TO_ASSUME
- AWS_REGION
- AWS_INSTANCE_ID

4. In the repository page on GitHub click on the "Actions" tab in the top navigation bar
5. In the left sidebar, click "EC Instance Management" workflow.
6. At the top of the workflow page, you'll see a "Run workflow" dropdown button. Click on it.
7. Terraform runs EC2 Instance, so in order for it to be stopped, select "Stop" action and press "Run workflow" button.
