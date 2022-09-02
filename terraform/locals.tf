locals {
  ami_id               = "FIXME"
  iam_instance_profile = "FIXME"
  key_name             = "FIXME"
  backend_subnet       = data.aws_subnet.backend.id
  frontend_subnet      = data.aws_subnet.frontend.id
  ssl_certificate_id   = data.aws_acm_certificate.main.arn
}
