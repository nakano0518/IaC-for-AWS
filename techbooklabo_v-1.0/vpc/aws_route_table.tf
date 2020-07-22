resource "aws_route_table" "techbooklabov1_public_route_table" {
	vpc_id = aws_vpc.techbooklabov1_vpc.id
}