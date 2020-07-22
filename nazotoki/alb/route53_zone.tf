# ホストゾーン: レコードのコンテナ。
# ドメイン名を申請する。
# ドメイン名とは？
# www.example.com: 完全修飾ドメイン名(FQDN)
# www: ホスト名(ホストが好きに決められる)⇒レコードで指定し、IPと紐づけられる。
# example.com: ドメイン名。下記で申請する。
resource　"aws_route53_zone" "nazotoki" {
	name = "nazotoki_share.com"	# 実際に使用するドメイン名
}

# (レコードから)ホストゾーンを参照するための設定
data "aws_route53_zone" "nazotoki" {
	name = "nazotoki_share.com"
}