#Complex Cloud State management - AWS/Terraform
(VPC-S3-RDS-Elasticache-MQ-Beanstalk)

SCENARIO

We have a cloud management team and they are in charge of deploying setup and managing
the infrastructure on the cloud and also very heavy usage of cloud services.
There will be regular provisioning requests and regular changes, regular deployments.
So if you have the heavy usage of cloud services and a very regular usage, then you should also get
into some problems.

COMMON PROBLEMS

-Infra setup is complex process
-Not repeatable
-Difficult to track, not centralized
-Chances of human error
-Managing manually is time consuming task

SOLUTION

-Configuration management of Infrastructure
-Automatic Setup (NO Human Errors)
-Maintain State of Infrastructure 
-Use Version Control [IAAC]
-Reusable code


STEPS

Setup Terraform with Backend
Setup VPC[Secure & HA]
Provision Beanstalk Environment
Provision Backend Services
		RDS
		Elastic Cache
		Active MQ
Automate creation of Security groups, Key Pair, Bastion Host

Detailed manual:

1. Create S3 bucket in AWS and backend-s3.tf file 

1.1. Specify resource to store backend in S3

1.2. Add bucket name and key location

1.3. Initialize the backend "s3" via terraform init

2. Create vars.tf file and define variables for AWS_REGION and AMIS

3. Specify aws provider in providers.tf file as variable: var.AWS_REGION

4. Generate keys via ssh-keygen with name: tf-cloud-state-key

4.1. Create keypairs.tf and define key_name as tf-cloud-state-key
and public_key as var.PUB_KEY_PATH

4.2. terraform plan and apply to create a key pair

5. VPC creation via module

5.1. Define variables for VPC_NAME, VPC_CIDR, 3 different AZ, 3 Private and 3 Public subnets

5.2. Add correct source to download the module from the Terraform Module Registry

5.3. Create file vpc.tf and add variables to VPC module

6. Specify 5 security groups

6.1. Security group for bean-elb - Outbound Anywhere - Inbound port 80

6.2. Security group for bastion host ec2 instance - Outbound Anywhere - Inbound port 22 and availabe only from my IP address.

6.3. Security group for beanstalk instance - Outbound Anywhere - 
Inbound available only from bastion on port 22

6.4. Security group for RDS, active MQ, Elastic cache - Outbound Anywhere -
Inbound available only from beanstalk instance

7. Create backend-services.tf to:

7.1. Group private subnets for RDS instances and ElastiCache

7.2. Add DB instance, Elasticache cluster and RMQ resources

7.1. Define variables for dbname, dbuser and dbpass and add them to DB instance resource

7.2. Define variables for RMQ username and password and add them to MQ broker resource

7.3. Add Backend security group to all 3 resources

8. Create file beanstalk-app.tf and add 2 resources: Elastic Beanstalk application and environment

8.1. Manage multiple settings for Elastic Beanstalk environment (Terraform documentaion should help)

8.2. Specify the security groups for Elastic Beanstalk Auto Scaling group and Elastic Beanstalk environment's load balancer

8.3. Set depends_on argument - This dependency ensures that the specified security groups are created or updated before the Elastic Beanstalk environment is created or updated

9. Bestion host creation 

9.1. Create file bastion-host.tf and add a EC2 resource

9.2. Use defined variables:
 AWS_REGION and AMIS
 Key pair

9.3. Specify the ID of the subnet in which to launch the EC2 instance

9.4. Specify a security group ID to associate with the EC2 instance

9.5 Push a Shell script to Bastion host and execute it.
Shell script should have the RDS instance endpoint, the username and password.
To extract it in a file, we need to create a template. (clarify correct option from the Terraform documentation)
Create a template file db.deploy-tmpl with the Shell commands which is going to initialize our RDS instance:
-This script, when executed on Bastion host instance, will set up the required tools, clone the specified Git repository, and then use MySQL to restore a database from the provided SQL backup file.

9.6. Specify provisioner to transfers a file (db-deploy.tmpl) to the EC2 instance, make it executable

9.7. Specify the connection details for remote execution, including the SSH user, private key file, and host (public IP of the EC2 instance).

9.8. Specify "depends_on" to ensure that the EC2 instance is created only after the specified AWS RDS instance has been created.

10. Artifact deployment

10.1. Set correct Endpoints in the application application.properties file for RDS, Memcached, RabbitMQ 

10.2. Set correct credentials from vars.tf file

10.3. run mvn install to generate the artifact 

10.4. Upload and Deploy artifact .war file to Beanstalk => Application version 

11. Verify connection via web

Verify login , memcached and RAbbitMQ (check if data is inserted in cache)



