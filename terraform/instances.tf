resource "aws_instance" "varnish" {
  ami                    = local.ami_id
  instance_type          = "c6i.xlarge"
  iam_instance_profile   = local.iam_instance_profile
  key_name               = local.key_name
  subnet_id              = local.backend_subnet
  vpc_security_group_ids = [data.aws_security_group.basic.id, aws_security_group.test.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 25
    volume_type           = "gp3"

    tags = {
      Name = "Varnish-Test-xvda"
    }
  }

  tags = {
    Name = "Varnish-Test"
  }
}

resource "aws_instance" "nginx" {
  ami                    = local.ami_id
  instance_type          = "c6i.xlarge"
  iam_instance_profile   = local.iam_instance_profile
  key_name               = local.key_name
  subnet_id              = local.backend_subnet
  vpc_security_group_ids = [data.aws_security_group.basic.id, aws_security_group.test.id]

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = 25
    volume_type           = "gp3"

    tags = {
      Name = "Nginx-Test-xvda"
    }
  }

  tags = {
    Name = "Nginx-Test"
  }
}
