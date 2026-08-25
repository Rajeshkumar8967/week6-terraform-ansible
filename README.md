# Week 6 DevOps — Terraform & Ansible

Infrastructure as Code (IaC) and Configuration Management practical project completed as part of the DevOps Internship Week 6 task.

## Overview

This project demonstrates the fundamentals of **Infrastructure as Code using Terraform** and **configuration management using Ansible**.

The implementation uses:

* **Terraform** for infrastructure provisioning
* **Docker** as the infrastructure platform
* **Nginx** as the web server
* **Ansible** for configuration management
* **Ubuntu 26.04 LTS on WSL2** as the DevOps control environment

The project demonstrates how infrastructure can be provisioned consistently with Terraform and configured through Ansible instead of relying entirely on manual server setup.

## Architecture

```text
                    WSL2 / Ubuntu
                         |
                         |
                  +------v------+
                  |   Terraform |
                  +------+------+
                         |
                         | Docker Provider
                         v
                +-------------------+
                | Docker Container  |
                |  week6-web-server |
                |       Nginx       |
                +---------+---------+
                          |
                          | Port 8080
                          v
                   http://localhost:8080
```

Ansible is used separately for configuration-management exercises through a local inventory and playbook.

## Technologies Used

| Technology       | Purpose                       |
| ---------------- | ----------------------------- |
| Terraform        | Infrastructure provisioning   |
| Docker           | Local infrastructure platform |
| Nginx            | Web server                    |
| Ansible          | Configuration management      |
| Ubuntu 26.04 LTS | Control environment           |
| WSL2             | Linux development environment |
| Git              | Version control               |
| GitHub           | Source-code repository        |

## Project Structure

```text
week6-terraform-ansible/
│
├── ansible/
│   ├── inventory
│   └── playbook.yml
│
├── docs/
│   └── Week-6-DevOps-Report.pdf
│
├── screenshots/
│   ├── 01- terraform installation.png
│   ├── 02- terraform init.png
│   ├── 03- terraform validate, plan.png
│   ├── 04- terraform apply.png
│   ├── 05- terraform apply output.png
│   ├── 06- terraform state list.png
│   └── 07- ansible playbook.png
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── .terraform.lock.hcl
│
├── .gitignore
└── README.md
```

Generated Terraform directories and state files are excluded from version control through `.gitignore`.

## Terraform Implementation

### Provider

The project uses the Docker Terraform provider:

```hcl
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}
```

### Infrastructure

Terraform provisions:

1. The `nginx:alpine` Docker image
2. A Docker container named `week6-web-server`

The container maps:

```text
Host:      8080
Container: 80
```

Therefore the Nginx web server is accessible at:

```text
http://localhost:8080
```

## Terraform Variables

The configuration uses variables instead of hard-coding the container name and host port.

### `container_name`

```text
Default: week6-web-server
```

### `host_port`

```text
Default: 8080
```

This makes the configuration easier to customize and reuse.

## Terraform Outputs

The configuration exposes:

* Provisioned container name
* Web server URL

Example:

```text
container_name = "week6-web-server"
web_url        = "http://localhost:8080"
```

## Terraform Workflow

The Terraform workflow used in this project is:

```text
terraform init
        |
        v
terraform validate
        |
        v
terraform plan
        |
        v
terraform apply
        |
        v
Infrastructure Created
        |
        v
terraform state list
```

### Initialize

```bash
terraform init
```

Downloads and initializes the required Terraform provider.

### Validate

```bash
terraform validate
```

Checks whether the Terraform configuration is syntactically and structurally valid.

### Plan

```bash
terraform plan
```

Shows the infrastructure changes Terraform intends to make before they are applied.

### Apply

```bash
terraform apply
```

Creates or updates the infrastructure according to the Terraform configuration.

### State

```bash
terraform state list
```

Displays resources currently managed by Terraform.

The project state contains the provisioned Docker image and container.

### Destroy

```bash
terraform destroy
```

Removes infrastructure managed by the Terraform configuration when the environment is no longer required.

## Ansible Implementation

Ansible is used for configuration-management exercises.

The inventory defines the local machine as the managed host:

```ini
[local]
localhost ansible_connection=local
```

The playbook performs the following configuration tasks:

### 1. Install a package

Installs the `curl` package.

### 2. Create a user

Creates:

```text
devopsuser
```

with `/bin/bash` as the shell.

### 3. Configure a service

Installs the `cron` package and starts the `cron` service with the service enabled.

## Running the Ansible Playbook

Run the playbook with:

```bash
sudo ansible-playbook -i inventory playbook.yml
```

The playbook should complete with a successful `PLAY RECAP`.

## Terraform vs Ansible

| Terraform                                     | Ansible                                             |
| --------------------------------------------- | --------------------------------------------------- |
| Infrastructure provisioning                   | Configuration management                            |
| Creates infrastructure resources              | Configures existing systems                         |
| Uses declarative infrastructure configuration | Uses playbooks and tasks                            |
| Manages infrastructure lifecycle              | Manages packages, users, services and configuration |
| Example: create Docker container              | Example: install package or start service           |

### Simple distinction

```text
Terraform → Provision infrastructure

Ansible → Configure infrastructure
```

They solve different parts of the DevOps automation process and can be combined in larger infrastructure workflows.

## Infrastructure as Code

Infrastructure as Code allows infrastructure to be defined in version-controlled configuration files rather than being created manually.

Benefits include:

* Repeatability
* Consistency
* Version control
* Reviewable infrastructure changes
* Automation
* Easier environment recreation

Terraform is the IaC tool used in this project.

## Terraform State

Terraform state allows Terraform to track the resources it manages.

For this project, Terraform tracks:

```text
docker_image.nginx
docker_container.web
```

The Terraform state files are intentionally excluded from Git version control.

## Terraform Modules

Terraform modules are reusable groups of Terraform configuration.

Modules can be used to organize infrastructure into reusable components and make larger Terraform projects easier to maintain.

A custom module is not required for this basic Week 6 implementation.

## Documentation

The `docs/` directory contains the Week 6 PDF report covering:

* Infrastructure as Code
* Terraform
* Terraform State
* Variables & Outputs
* Modules
* Ansible
* Inventory
* Playbooks
* Terraform vs Ansible

## Screenshots

The `screenshots/` directory contains evidence of the practical work, including:

* Terraform installation
* Terraform initialization
* Terraform validation and planning
* Terraform apply
* Terraform outputs
* Terraform state
* Ansible playbook execution

## Learning Outcomes

This project demonstrates practical understanding of:

* Infrastructure as Code
* Terraform providers
* Terraform resources
* Terraform variables
* Terraform outputs
* Terraform state
* Terraform lifecycle commands
* Ansible inventory
* Ansible playbooks
* Ansible modules
* Package management
* User management
* Service management
* Terraform vs Ansible responsibilities

## Week 6 Submission

The repository contains the required Weekly Task submission artifacts:

* GitHub repository
* Terraform `.tf` files
* Ansible inventory
* Ansible playbook
* PDF report
* Terraform execution screenshots
* Ansible playbook execution screenshot

## Repository

GitHub:

https://github.com/Rajeshkumar8967/week6-terraform-ansible

## Note

This repository documents the **Week 6 Weekly Task**. The separate Friday Hands-on Activity is not included as completed work in this README.
