data "aws_route53_zone" "techbooklabov1_domein" {
	name = "techbooklabo.net"
}

resource "aws_route53_record" "techbooklabov1_record_alb"{
	zone_id = data.aws_route53_zone.techbooklabov1_domein.zone_id
	name    = data.aws_route53_zone.techbooklabov1_domein.name
	type    = "A"

	alias {
		name                   = aws_lb.lb.dns_name
		zone_id                = aws_lb.lb.zone_id
		evaluate_target_health = true
	}
}