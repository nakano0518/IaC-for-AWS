# ホストゾーン: レコードのコンテナ。
# ドメイン名を申請する。
# ドメイン名とは？
# www.example.com: 完全修飾ドメイン名(FQDN)
# www: ホスト名(ホストが好きに決められる)⇒レコードで指定し、IPと紐づけられる。
# example.com: ドメイン名。下記で申請する。

# 実際に使用するドメイン名
# resource　"aws_route53_zone" "nazotoki" {
# 	name = "nazotoki_share.com"
# }

# (レコードから)ホストゾーンを参照するための設定
# 今回は、GUIからドメイン名を作成し、その際ホストゾーンが自動作成されているので
# その外部リソースをdata(データリソース)として取得する
data "aws_route53_zone" "nazotoki" {
  name = "nazotoki_share.com"
}