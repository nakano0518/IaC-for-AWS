resource "aws_route" "techbooklabov1_public_route" {
	route_table_id = aws_route_table.techbooklabov1_public_route_table.id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.techbooklabov1_internet_gateway.id
}