# Advanced DevOps Project

This project demonstrates a complete Infrastructure-as-Code (IaC) and CI/CD pipeline for deploying a containerized static website to AWS.

## Description

The project uses Terraform to provision the necessary AWS infrastructure, including an EC2 instance, an ECR container registry, and all required IAM roles. A GitHub Actions pipeline automates the process of building a Docker image, pushing it to ECR, and deploying it securely to the EC2 instance using AWS Systems Manager (SSM) instead of SSH.

## Features

- **Infrastructure as Code:** All AWS resources are managed by Terraform.
- **Dockerized Application:** The static website is served by Nginx in a Docker container.
- **CI/CD Automation:** GitHub Actions pipelines for both infrastructure and application deployment.
- **Secure Deployment:** Uses AWS SSM Run Command for deployments, avoiding the need for SSH keys or open SSH ports.
- **Tag-Based Releases:** The deployment pipeline is triggered by pushing new version tags (e.g., `v1.0.0`).
- **OIDC Authentication:** GitHub Actions securely authenticate with AWS using OpenID Connect.

## Prerequisites

Before you begin, ensure you have the following:
- An AWS Account
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) installed
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) installed and configured with credentials

## Setup Instructions

1.  **Clone the Repository:**
    ```sh
    git clone git@github.com:Veras-D/advanced-devops-project.git
    cd advanced-devops-project
    ```

2.  **Create IAM Roles for GitHub Actions:**
    This project requires IAM Roles in your AWS account for GitHub Actions to use. Create them with the following permissions and establish a trust relationship with your GitHub repository.

    *   **Build Role:** Needs permissions to push images to Amazon ECR.
    *   **Deploy Role:** Needs `ssm:SendCommand` and `ec2:DescribeInstances` permissions.
    *   **Terraform Role:** Needs broad permissions to manage your AWS resources (EC2, ECR, IAM, VPC, etc.).

3.  **Update Workflow Files:**
    Replace the placeholder `role-to-assume` ARNs in `.github/workflows/deploy.yaml` and `.github/workflows/terraform.yaml` with the real ARNs of the roles you created in the previous step.

4.  **Create GitHub Secrets:**
    In your GitHub repository settings under "Secrets and variables" > "Actions", create the following secret:
    *   `SSH_IP_ADDRESS`: Your local IP address, used by Terraform to allow SSH access for initial setup or debugging.

5.  **Deploy the Infrastructure:**
    Initialize and apply the Terraform configuration.
    ```sh
    cd Terraform
    terraform init
    terraform apply
    ```
    This will provision all the necessary AWS resources.

## Deployment Workflow

To deploy a new version of the website:

1.  Make your changes to the code in the `website/` directory.
2.  Commit your changes.
3.  Create and push a new version tag:
    ```sh
    git tag v1.0.1
    git push origin v1.0.1
    ```
4.  This will trigger the `Pipeline CI/CD` workflow in GitHub Actions, which will automatically build and deploy your new version.

## Manual Infrastructure Management

You can manage your Terraform infrastructure manually via the `Terraform CI/CD` workflow in the GitHub Actions tab. This allows you to run `terraform plan`, `apply`, or `destroy` from your browser.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
