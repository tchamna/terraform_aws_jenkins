# #!/bin/bash
# yum install wget unzip httpd -y
# systemctl start httpd
# systemctl enable httpd
# wget https https://www.tooplate.com/zip-templates/2108_dashboard.zip
# unzip -o 2108_dashboard.zip
# cp -r 2108_dashboard/* /var/www/html/
# systemctl restart httpd

#!/bin/bash
# yum install wget unzip httpd -y
# systemctl start httpd
# systemctl enable httpd

sudo yum update -y

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade -y
sudo dnf upgrade
# Add required dependencies for the jenkins package
sudo amazon-linux-extras install java-openjdk11 -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins

echo This is your Jenkins Password:
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# sudo dnf install java-11-openjdk -y
# sudo dnf install jenkins -y


# sudo systemctl daemon-reload

#Start Jenkins
