resource "aws_route53_record" "techbooklabov1_certificate" {
	zone_id = data.aws_route53_zone.techbooklabov1_domein.id
	name    = aws_acm_certificate.techbooklabov1_ssl.domain_validation_options[0].resource_record_name
	type    = aws_acm_certificate.techbooklabov1_ssl.domain_validation_options[0].resource_record_type
	records = [
		aws_acm_certificate.techbooklabov1_ssl.domain_validation_options[0].resource_record_value
	]
	ttl     = 60
}