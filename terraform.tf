

terraform {
  backend "s3" {
    bucket     = "mamamoney-test-terraform"
    region     = "eu-west-1"
    key        = "mamamoney-terraform"
    #DynomDB lock table
    dynamodb_table="terraform-test-locks"
    encrypt=true
  }
}
