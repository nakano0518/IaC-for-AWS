resource "aws_acm_certificate" "techbooklabov1_ssl" {
	domain_name              = data.aws_route53_zone.techbooklabov1_domein.name
	subject_alternative_names = []
	validation_method        = "DNS"
}