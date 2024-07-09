# terraform {
#   backend "s3" {
#     bucket = "highqfutness-tf-state-tf"
#     key    = "terraform.tfstate"
#     region = "us-west-2"
#     dynamodb_table = "terraform-dev-state-table"
#   }
# }