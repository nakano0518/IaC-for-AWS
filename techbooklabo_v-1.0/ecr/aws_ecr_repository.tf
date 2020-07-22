resource "aws_ecr_repository" "techbooklabo-v1-nginx" {
	name = "techbooklabo-v1-nginx"
}

resource "aws_ecr_repository" "techbooklabo-v1-app" {
	name = "techbooklabo-v1-app"
}