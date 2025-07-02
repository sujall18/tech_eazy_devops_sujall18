#!/bin/bash

sudo apt update -y

# 2. Install Java 21
sudo apt install -y openjdk-21-jdk

# 3. Install Git & Maven
sudo apt install -y maven

sudo apt update  
sudo apt install unzip -y
# 5. Install AWS CLI v2
if ! command -v aws &> /dev/null; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
fi

# Install pip and awscli
#sudo apt install -y python3-pip
#pip3 install awscli --upgrade --user

# 7. Set up AWS CLI
#aws configure set aws_access_key_id "$${AWS_ACCESS_KEY_ID}"
#aws configure set aws_secret_access_key "$${AWS_SECRET_ACCESS_KEY}"
#aws configure set default.region "$${AWS_REGION}"
## 8. Set up AWS CLI for S3
#aws configure set default.s3.signature_version s3v4
# 9. Set up AWS CLI for S3 bucket
#S3_BUCKET_NAME="$${S3_BUCKET_NAME:-techeazy-devops-logs}"
#aws s3api create-bucket --bucket "$${S3_BUCKET_NAME}" --region ap-south-1 --create-bucket-configuration #LocationConstraint=ap-south-1 || true


# 4. Clone the repo
git clone https://github.com/techeazy-consulting/techeazy-devops.git
cd techeazy-devops

# 6. Build the app
mvn clean package

# 8. Run the app on port 80 (needs root)
sudo java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar > app.log 2>&1 &
#sudo nohup java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar > app.log 2>&1 &

sleep 30

# 9. Upload logs to S3
aws s3 cp /var/log/cloud-init-output.log "s3://$${S3_BUCKET_NAME}/logs/cloud-init-output-$$(hostname)-$$(date +%Y%m%d%H%M%S).log" --region ap-south-1 || true
aws s3 cp app.log "s3://$${S3_BUCKET_NAME}/logs/app-$$(hostname)-$$(date +%Y%m%d%H%M%S).log" --region ap-south-1 || true

# Auto shutdown instance after 1 hour
sudo shutdown -h +60