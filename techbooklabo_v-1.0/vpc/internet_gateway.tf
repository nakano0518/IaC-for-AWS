resource "aws_internet_gateway" "techbooklabov1_internet_gateway" {
	vpc_id = aws_vpc.techbooklabov1_vpc.id
}