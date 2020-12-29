# (albなどの)サービスからS3への書き込み等を行う場合、バケットポリシーを設定する
resource "aws_s3_bucket_policy" "alb_log" {
	bucket = aws_s3_bucket.alb_log.id
	policy = data.aws_iam_policy_document.alb_log.json
}

data "aws_iam_policy_document" "alb_log" {
	statement {
		effect = "Allow"
		actions = ["s3:PutObject"]
		resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/benchmap-access-logs/*"]　# どのリソースへ書き込むか

		principals {
			type = "AWS"
			identifiers = ["582318560864"]	# 書き込みを行うELBアカウントID(リージョンごとに異なる)を指定。ap-northeast-1(東京)は582318560864を指定する。
		}
	}
}