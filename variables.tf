#----root/variables.tf-----
variable "aws_region" {
   default = "eu-west-1"
}

variable "aws_profile"{}

# Project name - use only lowercase as it is used for S3 which allows only lowercase!
variable "project_name" {
  default= "mama-money"
}

#-------networking variables
variable "vpc_cidr" {}
variable "public_cidrs" {
  type = list
}
variable "accessip" {}

#-------compute variables
variable "key_name" {}
variable "public_key_path" {}
variable "server_instance_type" {}
variable "instance_count" {
  default = 1
}
