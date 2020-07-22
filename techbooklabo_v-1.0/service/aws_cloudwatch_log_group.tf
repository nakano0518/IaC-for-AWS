resource "aws_cloudwatch_log_group" "techbooklabov1-app" {
	name = "app"
}

resource "aws_cloudwatch_log_group" "techbooklabov1-nginx" {
	name = "nginx"
}