terraform {
  backend "s3"{
    # bucket name
    # bucket = local.target_bucket_name

    # The key is the folder to use inside S3
    key = "mamamoney/s3/terraform.state"
    region = "eu-west-1"
    #dynamodb_table = local.dynamodb_table_name
    encrypt = "true"
  }
}
