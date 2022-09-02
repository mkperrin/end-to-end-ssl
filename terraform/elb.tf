resource "aws_elb" "varnish" {
  name            = "varnish-test"
  security_groups = [aws_security_group.test.id]
  subnets         = [local.frontend_subnet]
  internal        = false

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = local.ssl_certificate_id
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTPS:443/healthcheck"
    interval            = 10
  }

  idle_timeout                = 60
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 10
}

resource "aws_elb_attachment" "varnish" {
  elb      = aws_elb.varnish.id
  instance = aws_instance.varnish.id
}

resource "aws_elb" "nginx" {
  name            = "nginx-test"
  security_groups = [aws_security_group.test.id]
  subnets         = [local.backend_subnet]
  internal        = true

  listener {
    instance_port      = 443
    instance_protocol  = "https"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = local.ssl_certificate_id
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTPS:443/healthcheck"
    interval            = 10
  }

  idle_timeout                = 60
  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 10
}

resource "aws_elb_attachment" "nginx" {
  elb      = aws_elb.nginx.id
  instance = aws_instance.nginx.id
}
