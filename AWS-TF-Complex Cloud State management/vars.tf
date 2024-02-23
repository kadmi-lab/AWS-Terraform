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

variable "PRIV_KEY_PATH" {
  default = "tf-cloud-state-key"
}

variable "PUB_KEY_PATH" {
  default = "tf-cloud-state-key.pub"
}

variable "VPC_NAME" {
  default = "cloud-state-VPC"
}

variable "VPC_CIDR" {
  default = "172.21.0.0/16"
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
  default = "172.21.1.0/24"
}

variable "PublicSubnet2" {
  default = "172.21.2.0/24"
}

variable "PublicSubnet3" {
  default = "172.21.3.0/24"
}

variable "PrivateSubnet1" {
  default = "172.21.7.0/24"
}

variable "PrivateSubnet2" {
  default = "172.21.8.0/24"
}

variable "PrivateSubnet3" {
  default = "172.21.9.0/24"
}
