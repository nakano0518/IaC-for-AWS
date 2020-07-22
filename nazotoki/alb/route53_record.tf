# レコード：　ホスト名とIPアドレスを紐づけるAレコードなどがある。ホストゾーンに格納される。
resource "aws_route53_record" "nazotoki" {
  zone_id = data.aws_route53_zone.nazotoki.zone_id
  name    = data.aws_route53_zone.nazotoki.name
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}

# SSL証明書の検証用レコード
resource "aws_route53_record" "nazotoki_certificate" {
  name    = aws_acm_certificate.nazotoki.domain_validation_options[0].resource_record_name
  type    = aws_acm_certificate.nazotoki.domain_validation_options[0].resource_record_type
  records = [aws_acm_certificate.nazotoki.domain_validation_options[0].resource_record_value]
  zone_id = data.aws_route53_zone.nazotoki.id
  ttl     = 60
}