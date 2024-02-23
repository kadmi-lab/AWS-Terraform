resource "aws_key_pair" "tf-cloud-state-key" {
  key_name   = "tf-cloud-state-key"
  public_key = file(var.PUB_KEY_PATH)
}
