resource "aws_s3_bucket" "alb_log" {
	bucket = "nakano-alb-log"
	lifecycle_rule {
		enabled = true
		expiration {
			days = "180" # 180日経過したファイルを自動的に削除
		}
	}
	# バケット内にオブジェクトが残るとdestroyコマンドで削除できない
	# 下記の値をtrueにすることで、削除可能に
	force_destroy = false
}