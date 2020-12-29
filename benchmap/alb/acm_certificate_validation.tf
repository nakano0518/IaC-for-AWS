# 検証の待機
# apply時にSSL検証が完了するまで待つ。
resource "aws_acm_certificate_validation" "acm-validation" {
  certificate_arn         = aws_acm_certificate.benchmap.arn
  validation_record_fqdns = [aws_route53_record.benchmap_certificate.fqdn]
}