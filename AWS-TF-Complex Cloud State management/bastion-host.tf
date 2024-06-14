resource "aws_instance" "cloud-state-bastion" {

  ami                         = lookup(var.AMIS, var.AWS_REGION)
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.tf-cloud-state-key.key_name
  subnet_id                   = module.vpc.public_subnets[0]
  count                       = 1
  vpc_security_group_ids      = [aws_security_group.cloud-state-bastion-sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "cloud-state-bastion"
    Project = "complex-cloud-state-management"
  }

  provisioner "file" {
    content     = templatefile("./templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.cloud-state-RDS.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/cloud-state-dbdeploy.sh"


  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/cloud-state-dbdeploy.sh",
      "sudo /tmp/cloud-state-dbdeploy.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = var.USERNAME
    private_key = file(var.PRIV_KEY_PATH)
    host        = self.public_ip
  }


  depends_on = [aws_db_instance.cloud-state-RDS]
}
