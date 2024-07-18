# GOOD STARTING POINT: Why tfstate files need to be stored remotely(pros of remote backend): https://stackoverflow.com/questions/38486335/should-i-commit-tfstate-files-to-git

provider "aws" {
  region = "us-east-1" 
}

resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id= var.subnet_id
  tags = var.tags
}

module "backend_bucket" {
  source       = "../s3_bucket"
  bucket_name = var.bucket_name
}


resource "aws_dynamodb_table" "terraform_lock" {
  name           = var.table_name
  billing_mode   = var.billing_mode
  read_capacity  = 1
  write_capacity = 1
  hash_key       = var.hash_key # Its NoSQL based but it uniquely identifies it, kind of like a Primary key

  # attrs of the table: LockID is the only attr of type String
  attribute {
    name = "LockID"
    type = "S"
  }
}

# # NOTE 1 : Billing Modes in DynamoDB:

#     Provisioned Capacity:
#         Allows you to specify the read and write capacity units (RCUs and WCUs) your table requires. You are billed for these provisioned units regardless of usage.
#         Free Tier Impact: With provisioned capacity, AWS offers a free tier allowance that includes a certain amount of RCUs and WCUs per month. If your usage falls within these limits, you won't be charged for the provisioned capacity.

#     On-Demand (PAY_PER_REQUEST):
#         Charges are based on the number of read and write requests your application makes to DynamoDB. You are not charged for provisioned RCUs or WCUs.
#         Free Tier Impact: On-Demand capacity mode does not have a free tier offering for RCUs and WCUs. You will be charged for each request, but there is a free tier for data storage.

# # NOTE 2: Hash Keys (Partition Keys) in DynamoDB:

#     Hash Key (Partition Key): This is the attribute that DynamoDB uses to partition data across multiple servers. It determines the partition (physical storage location) of items in the table based on the hash value of this attribute.
#     Range Key (Sort Key): Optionally, a table can also have a range key, which is used to organize items with the same partition key value. Together, they form the composite primary key.