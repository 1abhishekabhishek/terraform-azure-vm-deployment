# Terraform Azure VM Deployment

This project deploys Azure Virtual Machine infrastructure on Microsoft Azure using Terraform.

## Resources Created

- Resource Group
- Virtual Network (VNet)
- Subnet
- Network Security Group (NSG)
- Public IP Address
- Network Interface (NIC)
- Windows Virtual Machine

## Technologies Used

- Terraform
- Microsoft Azure
- Infrastructure as Code (IaC)

## Deployment Steps

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply

Azure Architecture

Resource Group │ ├── Virtual Network │ └── Subnet │ ├── Network Security Group │ ├── Public IP │ ├── Network Interface │ └── Windows Virtual Machine

Learning Objectives
Terraform Basics
Azure Networking
VM Deployment Automation
Infrastructure as Code
Azure Resource Dependencies
Author

Abhishek Mehta
| Azure Administrator |  DevOps Engineer
