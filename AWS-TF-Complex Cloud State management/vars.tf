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
