# TechEazy DevOps EC2 Automation

This project automates the deployment of an EC2 instance on AWS using Terraform. The instance installs Java 21, clones a GitHub repo, and deploys a web application.

---

## 🚀 Features

- Launches Ubuntu EC2 instance in `ap-south-1`
- Installs Java 21, Maven
- Clones and runs the app from GitHub
- App is accessible via port 80
- Security group allows HTTP traffic
- Supports different environments via `stage` variable
- Stops EC2 instance after usage 

------
## 🧾 Files Included

| File                | Purpose                               |
|---------------------|----------------------------------------|
| `main.tf`           | Terraform config to launch EC2         |
| `variables.tf`      | Input variable definitions             |
| `outputs.tf`        | Outnput variable definitions           |
| `user_data.sh`      | Shell script to install & deploy app   |

---

## 🔧 Requirements

- AWS account (Free tier is fine)
- AWS CLI configured (`aws configure`)
- Terraform installed
- SSH Key Pair set up in AWS 

---

## ⚙️ How to Use

```bash
terraform init
terraform plan
terraform apply -auto-approve
