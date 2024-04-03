terraform {
  required_version = "=1.7.5"

  backend "local" {
    path = "./localstate.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.43.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_config_files      = ["/home/priyanka/.aws/config"]
  shared_credentials_files = ["/home/priyanka/.aws/credentials"]

  default_tags {
    tags = {
      Creator   = "priyankatuladharmail@gmail.com"
      Deletable = "Yes"
      Project   = "Intern"
      Name      = "priyanka terraform task"
    }
  }

}

