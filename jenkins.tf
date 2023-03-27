module "jenkins_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Jenkins-SG"
  description = "Security group for Jenkins"
  vpc_id      = "vpc-0a7fd9a74f76ade2c"

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["http-80-tcp"]
  egress_rules             = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Jenkins-Server"

  ami                    = "ami-04581fbf744a7d11f"
  instance_type          = "t3.micro"
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_sg.security_group_id]
  subnet_id              = "subnet-0fb9431f8b7d5c136"
  user_data              = file("./dependencias.sh")
  iam_instance_profile    = "LabInstanceProfile"

  tags = {
    Name   = "Jenkins-Server"
    Environment = "Prod"
  }
}

resource "aws_eip" "jenkins-ip" {
  instance = module.ec2_instance.id
  vpc      = true
}
