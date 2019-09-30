##### AWS Authentication credentials
access_key = "REDACTED"				# Your AWS account access key
secret_key = "REDACTED"		# Your AWS account secret key

##### Terraform s3 backend configuration
region 		= "REDACTED"				# AWS region
bucket 		= "build-terraform-REDACTED"			# AWS S3 bucket to store terraform backend
dynamodb_table 	= "build-terraform-REDACTED"			# AWS DynamoDB table to store lock for terraform backend statefile
key 		= "build-REDACTED.tfstate"			# The path within the S3 bucket to store backend statefile for this terraform configuration

