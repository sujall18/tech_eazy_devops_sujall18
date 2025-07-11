# TechEazy DevOps EC2 Automation

This project automates the deployment of an EC2 instance on AWS using Terraform. The instance installs Java 21, clones a GitHub repo, and deploys a web application.

----

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
```
# 🚀 Assignment 3 – Automate Java App Deployment on AWS using GitHub Actions & Terraform

## 📌 Objective

The goal of Assignment 3 is to fully automate the deployment and teardown of a Java web application on AWS EC2 using GitHub Actions as the CI/CD tool and Terraform as the Infrastructure-as-Code (IaC) tool.

---

## ✅ Features

- **CI/CD via GitHub Actions**
- **Terraform-based AWS Infrastructure Provisioning**
- **Java App Deployment on EC2**
- **App Health Check & S3 Readiness Signal**
- **S3 Bucket for Logs**
- **Automatic Cleanup (`terraform destroy`) after 30 minutes**

---

## 🛠️ Tech Stack

- AWS (EC2, S3, IAM)
- Terraform
- GitHub Actions
- Java (Spring Boot)
- Ubuntu

---


---

## ⚙️ How It Works

### 🔁 GitHub Actions Workflow

1. On push to `assignment3` or manual dispatch (`workflow_dispatch`)
2. Provisions EC2 + S3 using Terraform
3. Waits for `app.txt` uploaded by EC2 to S3 as readiness signal
4. Health checks app on port 80 using `curl`

### 📄 `user_data.sh`

- Installs Java, Maven, AWS CLI
- Clones the app repo and builds the app
- Runs the Spring Boot app
- Uploads readiness file (`app.txt`) to S3
- Uploads app & cloud-init logs
- Auto-shuts down after 1 hour

---

## 📥 Inputs (workflow_dispatch)

| Input | Description | Default |
|-------|-------------|---------|
| `stage` | Deployment stage (`dev` or `prod`) | `dev` |

---

## ✅ Output

- Live EC2 instance with app deployed
- Logs stored in S3: `/logs/` & `/status/app.txt`

---

## 🔐 Secrets Required

| Secret | Description |
|--------|-------------|
| `AWS_ACCESS_KEY_ID` | AWS IAM access key |
| `AWS_SECRET_ACCESS_KEY` | AWS IAM secret key |
| *(Optional)* `EC2_PRIVATE_KEY` | If SSH login is required |

---

## 🙋‍♂️ Author

**Sujal Joseph Gaddam**  
AWS & DevOps Intern @ TechEazy  
[GitHub](https://github.com/sujall18)

---


