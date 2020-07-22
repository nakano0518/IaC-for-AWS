resource "aws_lb_listener" "http" {
	load_balancer_arn = aws_lb.alb.arn
	port = 80
	protocol = "HTTP"	# HTTP or HTTPS

	default_action {	# リスナーのルールに合致しない場合のデフォルトアクション
		# 3つのtypeが設定できる
		# forward: リクエストを別のターゲットグループに転送
		# fixed-response: 固定のHTTPレスポンスを応答
		# redirect: 別のURLにリダイレクト
		type = "fixed-response"
		fixed_response {
			content_type = "text/plain"
			message_body = "access by HTTP"
			status_code = "200"
		}
	}
}

resource "aws_lb_listener" "https" {
	load_balancer_arn = aws_lb.alb.arn
	port = 443
	protocol = "HTTPS"	
	certificae_arn = aws_acm_certificate.nazotoki.arn # ここで作成したSSL証明書の使用 　
	ssl_policy = "ELBSecurityPolicy-2016-08"  # 2020/7時点ではこのポリシーの使用が推奨
	# (参照) https://docs.aws.amazon.com/ja_jp/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies

	default_action {
		type = "fixed-response"
		fixed_response {
			content_type = "text/plain"
			message_body = "access by HTTPS"
			status_code = "200"
		}
	}
}

# リダイレクトリスナー(HTTPからHTTPSにリダイレクトする)
resource "aws_lb_listener" "redirect_http_to_https" {
	load_balancer_arn = aws_lb.alb.arn
	port = 8080  # albのセキュリティグループでport8080の使用を許可している
	protocol = "HTTP"

	default_action {
		type = "redirect"
		redirect {
			port = 443
			protocol = "HTTPS"
			status_code = "HTTP_301"
		}
	}
}