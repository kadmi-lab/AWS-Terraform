#AWS Complex Cloud State management - Deployment via Terraform
(VPC-S3-RDS-Elasticache-MQ-Beanstalk)

1. Create S3 bucket in AWS

1.1. Create backend-s3.tf file 

1.2. Define to store backend in S3

1.3. Add bucket name and key location

1.4. Initialize the backend "s3" via terraform init

2. Define aws provider in providers.tf file as variable: var.AWS_REGION

3. Create vars.tf file and define variables for AWS_REGION and AMIS

4. Generate keys via ssh-keygen with name: tf-cloud-state-key

4.1 Create keypairs.tf and define key_name as tf-cloud-state-key
and public_key as var.PUB_KEY_PATH

4.2 terraform plan and apply to create a key 

