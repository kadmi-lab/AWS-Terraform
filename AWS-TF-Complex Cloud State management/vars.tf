variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-06aa3f7caf3a30282"
    us-east-2 = "ami-07b36ea9852e986ad"
    us-west-1 = "ami-0da7657fe73215c0c"
  }
}

variable "INSTANCE_TYPE" {
  default = "t2.micro"
}


variable "PRIV_KEY_PATH" {
  default = "tf-cloud-state-key"
}

variable "PUB_KEY_PATH" {
  default = "tf-cloud-state-key.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}




variable "VPC_NAME" {
  default = "cloud-state-VPC"
}

variable "VPC_CIDR" {
  default = "172.../16"
}

variable "AZ1" {
  default = "us-east-1a"
}

variable "AZ2" {
  default = "us-east-1b"
}

variable "AZ3" {
  default = "us-east-1c"
}

variable "PublicSubnet1" {
  default = "172.../24"
}

variable "PublicSubnet2" {
  default = "172.../24"
}

variable "PublicSubnet3" {
  default = "172.../24"
}

variable "PrivateSubnet1" {
  default = "172.../24"
}

variable "PrivateSubnet2" {
  default = "172.../24"
}

variable "PrivateSubnet3" {
  default = "172.../24"
}



variable "MYIP" {
  default = ""
}



variable "dbname" {
  default = ""
}

variable "dbuser" {
  default = ""
}

variable "dbpass" {
  default = ""
}


variable "rmquser" {
  default = ""
}

variable "rmqpass" {
  default = ""
}
