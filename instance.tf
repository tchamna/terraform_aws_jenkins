#Find the video here: https://www.youtube.com/watch?v=9XrYwfIWDL0

# resource "aws_key_pair" "my_public_key" {
#   key_name   = "dovekey"
#   public_key = file("dovekey.pub")
# }

resource "aws_default_vpc" "aws_default_vpc" {
  tags = {
    "Name" = "default vpc"
  }

}



# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# create default subnet if one does not exit
resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags = {
    Name = "default subnet"
  }
}



# create security group for the ec2 instance
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2 security group"
  description = "allow access on ports 8080 and 22"
  vpc_id      = aws_default_vpc.aws_default_vpc.id

  # allow access on port 8080
  ingress {
    description = "http proxy access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # allow access on port 22
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins server security group"
  }
}



# use data source to get a registered amazon linux 2 ami
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "jenkins_inst" {
  ami               = data.aws_ami.amazon_linux_2.id
  instance_type     = "t2.micro"
  subnet_id         = aws_default_subnet.default_az1.id
  availability_zone = var.ZONE1
  # key_name               = aws_key_pair.my_public_key.key_name
  key_name               = "tchamna_aws"
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]
  tags = {
    Name    = "jenkins_instance"
    Project = "Jenkins Server"
  }
}



resource "null_resource" "name" {



  connection {
    type = "ssh"
    user = var.USER
    #private_key = file("dovekey")
    private_key = file("tchamna_aws.pem") # This key should be in the root folder of your project. Otherwise, you will have to specify its absolute path


    host = aws_instance.jenkins_inst.public_ip
  }


  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sh /tmp/web.sh",
    ]
  }

  depends_on = [
    aws_instance.jenkins_inst
  ]

}

#Print the URL
output "website_url_PUBLIC_DNS" {
  value = join("", ["http://", aws_instance.jenkins_inst.public_dns, ":", "8080"])

}

#Print the URL
output "website_url_PUBLIC_IP" {
  value = join("", ["http://", aws_instance.jenkins_inst.public_ip, ":", "8080"])
}

