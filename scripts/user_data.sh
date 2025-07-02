#!/bin/bash

sudo apt update -y

# 2. Install Java 21
sudo apt install -y openjdk-21-jdk

# 3. Install Git & Maven
sudo apt install -y git maven

# 4. Clone the repo
git clone https://github.com/techeazy-consulting/techeazy-devops.git
cd techeazy-devops

# 6. Build the app
mvn clean package

# 8. Run the app on port 80 (needs root)
sudo java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar
#sudo nohup java -jar target/techeazy-devops-0.0.1-SNAPSHOT.jar > app.log 2>&1 &

# Auto shutdown instance after 1 hour
sudo shutdown -h +60