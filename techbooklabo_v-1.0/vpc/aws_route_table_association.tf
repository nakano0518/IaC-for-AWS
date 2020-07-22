resource "aws_route_table_association" "techbooklabov1_public_1_route_table_association" {
	subnet_id = aws_subnet.techbooklabov1_public_subnet_1.id
	route_table_id = aws_route_table.techbooklabov1_public_route_table.id
}

resource "aws_route_table_association" "techbooklabov1_public_2_route_table_association" {
	subnet_id = aws_subnet.techbooklabov1_public_subnet_2.id
	route_table_id = aws_route_table.techbooklabov1_public_route_table.id
}