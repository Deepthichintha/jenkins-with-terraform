# jenkins-with-terraform
📌 Project Title

Jenkins Installation on AWS EC2 using Terraform

📖 Project Overview

This project demonstrates how to provision an AWS EC2 instance using Terraform and automatically install Jenkins using Linux provisioning.
It helps beginners understand Infrastructure as Code (IaC) and real-world DevOps automation.

🛠️ Tools & Technologies Used

Terraform

AWS EC2

AWS CLI

Ubuntu Linux

Jenkins

Systemd (Daemon Services)

📂 Project Structure
.
├── provider.tf
├── resource.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
└── README.md

⚙️ Prerequisites

Before starting, ensure you have:

AWS Account

IAM User with EC2 permissions

AWS CLI installed & configured

Terraform installed

Key pair created in AWS

Basic Linux knowledge

🔐 AWS Configuration

Configure AWS CLI:

aws configure


Provide:

Access Key

Secret Key

Region

Output format

🧱 Terraform Configuration
🔹 Provider Configuration
provider "aws" {
  region = "us-east-1"
}

🔹 EC2 Resource with Jenkins Installation
resource "aws_instance" "jenkins" {
  ami           = "ami-xxxxxxxx"
  instance_type = "t2.micro"
  key_name      = "terraform-key"

  user_data = <<-EOF
    #!/bin/bash
    apt update -y
    apt install -y openjdk-11-jdk
    curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | tee \
      /usr/share/keyrings/jenkins-keyring.asc > /dev/null
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
      https://pkg.jenkins.io/debian binary/ | tee \
      /etc/apt/sources.list.d/jenkins.list > /dev/null
    apt update -y
    apt install -y jenkins
    systemctl start jenkins
    systemctl enable jenkins
  EOF

  tags = {
    Name = "Jenkins-Server"
  }
}

🚀 Steps to Run the Project
1️⃣ Initialize Terraform
terraform init

2️⃣ Validate Configuration
terraform validate

3️⃣ Preview Infrastructure
terraform plan

4️⃣ Apply Configuration
terraform apply


Type yes when prompted.

🌐 Access Jenkins

After EC2 creation:

Jenkins URL:

http://<EC2_PUBLIC_IP>:8080


Get initial admin password:

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

🔁 Jenkins as a Daemon Service

Jenkins runs as a systemd daemon service.

Check Jenkins status:
systemctl status jenkins

Restart Jenkins:
systemctl restart jenkins

🧠 Key Learnings

Infrastructure as Code using Terraform

EC2 provisioning

Jenkins installation automation

Understanding daemon services

Debugging Terraform & Linux issues

❗ Common Issues Faced

Invalid key pair error

Wrong AMI for OS

Security group port issues

Jenkins service not starting

✔️ All issues were resolved by validating configurations and logs.

📌 Future Enhancements

Use Terraform provisioners

Add Elastic IP

Install Jenkins using Ansible

Create CI/CD pipeline

Add ALB & HTTPS

🙌 Conclusion

This project helped me understand real-time DevOps automation using Terraform and Jenkins.
It is a strong foundation for CI/CD and cloud infrastructure management.
