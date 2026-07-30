#Terraform Settings Block
terraform {
  required_version = "~>1.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.97.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.7.0"
    }
    localos = {
      source  = "fireflycons/localos"
      version = "0.1.2"
    }
  }


  #Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket       = "tf-state-srp-apr02" #"kkp-test-bkt-v0"
    key          = "dev/aws-k8s-setup-prod/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true #S3 native locking    
    #dynamodb_table = "dev-ekscluster" # For DynamoDB State Locking

  }/*
  #Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket       = "kkp-test-bkt-v0" #"tf-state-srp-apr02"
    key          = "dev/manual-cluster/terraform.tfstate"
    region       = "ap-southeast-2"
    use_lockfile = true #S3 native locking    
    #dynamodb_table = "dev-ekscluster" # For DynamoDB State Locking

  }
  */
}

# Terraform Provider Block
provider "aws" {
  region = var.aws_region
}


