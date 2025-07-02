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
