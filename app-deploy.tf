resource "null_resource" "app" {
  count = local.INSTANCE_COUNT

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = jsondecode(data.aws_secretsmanager_secret_version.secrete_version.secret_string)["SSH_USERNAME"]
      password = jsondecode(data.aws_secretsmanager_secret_version.secrete_version.secret_string)["SSH_PASSWORD"]
      host = element(local.INSTANCE_PRIVATE_IPS, count.index)
    }
    inline = [ 
        "echo hai"

     ]
  }
}
