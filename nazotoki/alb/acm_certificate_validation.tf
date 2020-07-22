# 検証の待機
# apply時にSSL検証が完了するまで待つ。
resource "aws_acm_certificate_validation" {
	certificate_arn = aws_acm_certificate.nazotoki.arn
	validation_record_fqdns = [aws_route53_record.nazotoki_certificate.fqdn]
}