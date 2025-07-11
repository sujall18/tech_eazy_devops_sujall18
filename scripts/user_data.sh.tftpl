#!/bin/bash
set -e

# Update system
apt-get update -y
apt-get install -y  unzip curl openjdk-21-jdk git maven

# Install AWS CLI v2 if not installed
if ! command -v aws &> /dev/null; then
  echo "Installing AWS CLI..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
fi

# Clone repo and run
cd /home/ubuntu
git clone ${REPO_URL}
cd $(basename "${REPO_URL}" .git)

mvn clean install
java -jar target/*.jar --server.port=80 > /var/log/my-app.log 2>&1 &

# Wait for a bit to let the app run
sleep 120

# Upload logs to S3 bucket passed from Terraform
aws s3 cp /var/log/cloud-init.log s3://${log_s3_bucket_name}/system_logs/cloud-init.log
aws s3 cp /var/log/my-app.log s3://${log_s3_bucket_name}/app_logs/my-app.log

# Auto-shutdown
sudo shutdown -h +$(shutdown_after_minutess)
