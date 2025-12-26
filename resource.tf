resource "aws_instance" "jenkins" {
  ami                    = "ami-0ecb62995f68bb549"
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  user_data              = <<-EOF
#!/bin/bash
set -e

# Update system
apt-get update -y

# Install Java (Jenkins requirement)
apt-get install -y openjdk-17-jdk

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index again
apt-get update -y

# Install Jenkins
apt-get install -y jenkins

# Start and enable Jenkins
systemctl start jenkins
systemctl enable jenkins
EOF


  tags = {
    Name = "Jenkins-Server"
  }
}
