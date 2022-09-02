resource "aws_route53_record" "varnish" {
  zone_id = data.aws_route53_zone.dev.zone_id
  name    = "varnish-test.${data.aws_route53_zone.dev.name}"
  type    = "A"

  alias {
    name                   = aws_elb.varnish.dns_name
    zone_id                = aws_elb.varnish.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "nginx" {
  zone_id = data.aws_route53_zone.dev.zone_id
  name    = "nginx-test.${data.aws_route53_zone.dev.name}"
  type    = "A"

  alias {
    name                   = aws_elb.nginx.dns_name
    zone_id                = aws_elb.nginx.zone_id
    evaluate_target_health = true
  }
}
