terraform {
  backend "s3" {
    # Workaround for Error: Variables not allowed when var.variable_name is used -> Using terraform init -backend-config="key1=value1" -backend-config="key2=value2" etc.. OR just hardcode values OR just store in a file backend.hcl for instance and pass it to backend-config: terraform init -backend-config=backend.hcl
    # Good reference: https://brendanthompson.com/posts/2021/10/dynamic-terraform-backend-configuration

    # bucket         = var.bucket_name
    key            = "terraform/terraform.tfstate"
    region         = "us-east-1"
    # dynamodb_table = var.table_name
    encrypt        = true # specifies that the state file should be encrypted at rest using server-side encryption provided by AWS S3.

    # Both bucket and dynamodb_table ar ebeing set dynamically
  }
}
