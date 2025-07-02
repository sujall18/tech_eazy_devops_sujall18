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

---

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

# TechEazy DevOps Assignment 2 – EC2 Automation with Terraform, IAM, S3 & Logs

This assignment builds on top of Assignment 1 and automates advanced DevOps tasks using **Terraform**, **AWS CLI**, **IAM**, **S3**, and **Bash scripting**.

---

## 📦 Features Implemented

1. **Terraform-based EC2 Instance Deployment**
   - Ubuntu 22.04 EC2 in `ap-south-1` (Mumbai)
   - Instance tagged and named based on `stage` input

2. **IAM Role & Policy Setup**
   - `s3-readonly-role` — read-only access to S3 (attached manually for verification)
   - `s3-upload-role` — create bucket, upload logs (no read/download access)
   - Roles are created via `iam.tf` and passed using `iam_instance_profile`

3. **Private S3 Bucket Setup**
   - Created using `s3.tf`
   - Bucket name is configurable via `bucket_name` variable
   - Lifecycle policy to delete logs after 7 days
   - Public access fully blocked

4. **App Setup & Logging via `user_data.sh`**
   - Installs Java, Maven, AWS CLI
   - Clones app from GitHub, builds via Maven
   - Runs the Spring Boot JAR and captures logs to `app.log`
   - Uploads:
     - `/var/log/cloud-init-output.log` → `s3://<bucket>/logs/dev/`
     - `app.log` → `s3://<bucket>/logs/dev/app/`
   - Instance auto-shutdown after 1 hour

---

## 🔧 How to Use

### 1. Variables to Set
In `terraform/variables.tf`:
- `bucket_name` (Required)
- `stage` (dev / prod)

Example:
```bash
terraform apply -var="bucket_name=tech-eazy-tucandu" -var="stage=dev"

