# Terraform GitHub Actions

![Terraform](https://img.shields.io/badge/Terraform-IaC-623CE4?logo=terraform\&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-CI/CD-2088FF?logo=github-actions\&logoColor=white)
![CI Status](https://github.com/betussi/terraform-github-actions/actions/workflows/terraform.yml/badge.svg)
![Repo Size](https://img.shields.io/github/repo-size/betussi/terraform-github-actions)
![Last Commit](https://img.shields.io/github/last-commit/betussi/terraform-github-actions)

---

# 🇺🇸 English

This repository demonstrates how to use **Terraform** with **GitHub Actions** to automate infrastructure provisioning using **Infrastructure as Code (IaC)**.

The CI/CD pipeline automatically runs Terraform commands when changes are pushed to the repository, allowing infrastructure to be validated and deployed in a controlled and automated way.

## 🚀 Overview

This project integrates:

* **Terraform** for Infrastructure as Code
* **GitHub Actions** for CI/CD automation
* Automated validation and deployment workflows

Infrastructure changes can be versioned, reviewed via Pull Requests, and automatically applied after approval.

---

# 🇧🇷 Português

Este repositório demonstra como utilizar **Terraform** com **GitHub Actions** para automatizar o provisionamento de infraestrutura utilizando **Infrastructure as Code (IaC)**.

O pipeline de **CI/CD** executa automaticamente comandos do Terraform sempre que alterações são enviadas para o repositório, permitindo validar e implantar infraestrutura de forma controlada e automatizada.

## 🚀 Visão Geral

Este projeto integra:

* **Terraform** para Infraestrutura como Código
* **GitHub Actions** para automação de CI/CD
* Pipeline automatizado para validação e deploy

Com essa abordagem, mudanças na infraestrutura podem ser versionadas, revisadas por **Pull Requests** e aplicadas automaticamente após aprovação.

---

# 📂 Repository Structure

```
.
├── .github
│   └── workflows
│       └── terraform.yml
├── main.tf
└── README.md
```

---

# ⚙️ Workflow Pipeline

The GitHub Actions pipeline runs the following steps:

1. Checkout repository
2. Setup Terraform
3. Terraform Format Check
4. Terraform Init
5. Terraform Validate
6. Terraform Plan
7. Terraform Apply (on main branch)

---

# 🔐 Required Secrets

Depending on the cloud provider, you may need to configure repository secrets.

Example (Azure):

| Secret              | Description                       |
| ------------------- | --------------------------------- |
| ARM_CLIENT_ID       | Azure Service Principal Client ID |
| ARM_CLIENT_SECRET   | Azure Service Principal Secret    |
| ARM_SUBSCRIPTION_ID | Azure Subscription ID             |
| ARM_TENANT_ID       | Azure Tenant ID                   |

---

# ▶️ Running Terraform Locally

Initialize Terraform:

```
terraform init
```

Validate configuration:

```
terraform validate
```

Preview changes:

```
terraform plan
```

Apply infrastructure:

```
terraform apply
```

---

# 🤝 Contributing

Contributions are welcome.

1. Fork the repository
2. Create a new branch
3. Commit your changes
4. Open a Pull Request

---

# ⭐ Support

If you find this repository useful, consider giving it a ⭐ on GitHub.
