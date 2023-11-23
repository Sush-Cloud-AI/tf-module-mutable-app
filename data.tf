
# reads data from the vpc remote state file. to use it
data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "my-bucket-tfstate-sus"
        key    = "vpc/${var.ENV}/terraform.tfvars"
        region = "us-east-1"
    }
  
}

## to fetech the infromation of the secrete
data "aws_secretsmanager_secret" "secretes" {
  name = "robot/secretes"
}

## fetch the secrete version from the above server 

data "aws_secretsmanager_secret_version" "secrete_version" {
  secret_id = data.aws_secretsmanager_secret.secretes.id
}

# fect ami dynamically 
data "aws_ami" "ami" {
  most_recent = true
  name_regex = "devops-ami"
  owners = ["self"]
}