terraform {
  backend "s3" {
    bucket = "delpadre-vorx-terraform"
    key = "jenkins-server.tfstate"
    region = "us-east-1"
  }
}
