data "aws_vpc" "main" {
  id = "FIXME"
}

data "aws_route53_zone" "dev" {
  name = "FIXME"
}

data "aws_security_group" "basic" {
  name   = "FIXME"
  vpc_id = data.aws_vpc.main.id
}

data "aws_subnet" "backend" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = ["FIXME"]
  }
}

data "aws_subnet" "frontend" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = ["FIXME"]
  }
}

data "aws_acm_certificate" "main" {
  domain      = "FIXME"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}
