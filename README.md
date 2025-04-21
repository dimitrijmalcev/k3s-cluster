# Cloud-Agnostic K3S Cluster with GitOps 

This repository contains the IaC (Terragrunt with Terraform) for setting up a ready cluster based on K3S using Amazon Web Services Cloud Services, Hetzner Cloud or On-Premise (local setup) and connecting GitOps to provision the required Applications and Services for development.

# Disclaimer

This repository and the included code are provided for demonstration, testing, and educational purposes only. Use of this code is at your own risk. No warranties are provided regarding its functionality, correctness, security, or suitability for production environments. In particular, when deploying in cloud or on-premises infrastructure, it is strongly recommended to review, adapt, and test the code thoroughly in a safe and isolated environment before using it in production. Organizations or individuals intending to use this code in commercial or sensitive environments do so at their own discretion and are responsible for ensuring compliance with their internal security, legal, and operational requirements.

The author accepts no liability for any damages, outages, data loss, or costs resulting from the use of this code.

# Architecture 

## Terragrunt Process
![K3S-GitOps-Architecture](./images/architecture/Architecture-Process-Terragrunt.png)

## K3S Cluster
![K3S-GitOps-Architecture](./images/architecture/Architecture-GitOps.png)


# Video Series

| Video-Link       | Context       | Title       |
|----------------|----------------|----------------|
| [![Fully Functional K3S Cluster using Terraform with GitOps and CI/CD (Cloud-Agnostic)](./images/01-Introduction.jpg)](https://youtu.be/0hv2gsLXsis)  | 01 - Introduction  | <i>Fully Functional K3S Cluster using Terraform with GitOps and CI/CD (Cloud-Agnostic)</i>  |
| [![Enterprise Kubernetes in Minutes - Fully Automated with Terragrunt](./images/02-Architecture.png)](https://youtu.be/atbltYN-wno) |  02 - Architecture | <i>Enterprise Kubernetes in Minutes - Fully Automated with Terragrunt</i>  |
| upcoming |  03 - Project Setup and Hetzner Cloud Infrastructure | <i>upcoming</i>  |


# Prerequisites

- Terraform and Terraform required in your environment (see: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli and https://terragrunt.gruntwork.io/docs/getting-started/install/) (tested with Terraform v1.5.7 and Terragrunt version 0.77.7)
- AWS CLI with a valid profile (if you want to use SSM-Parameter Store for fetching Secrets and provisioninig AWS resources)
- Git
- A Valid Hetzner Cloud Account with a Token
- SSH Public Key

# How to use

1. Configure the environment under `envs/dev/env.hcl` and the general project configuration under `root.hcl` (development)
2. To provision the resources using terragrunt: `bash execution/apply-dev.sh`   (development)
3. To destroy the resources using terragrunt: `bash execution/destroy-dev.sh`  (development)
4. Optionally configure additional environments