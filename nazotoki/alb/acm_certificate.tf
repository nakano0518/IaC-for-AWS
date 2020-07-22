# ACM(AWS Certificate Manager)でHTTPS化するためのSSL証明書を作成。
# SSL証明書の作成の他、ドメイン検証、SSL証明書の自動更新を担うサービス。

resource "aws_acm_certificate" "nazotoki" {
	domain_name = "www.${data.aws_route53_zone.nazotoki.name}"　 # FQDN
	subject_alternative_names = []					    # ドメイン名を追加する場合、この項目に追加する
	validation_method = "DNS"							# ドメイン所有者の検証方法。Eメール検証かDNS検証か選択。SSL証明書を自動更新できるDNS検証を使用する。
	# (証明書の自動更新時)新しいSSL証明書を作成し、古いSSL証明書と差し替えるという挙動。サービスへの影響を最小化する。
	# 全てのリソースでこの項目の記載可能。lifecycleでcreate_before_destroyをtrueにすると、「リソースを作成してからリソースを削除する」という挙動。デフォルトはその逆。
	lifecycle {
		create_before_destroy = true					
	}
}