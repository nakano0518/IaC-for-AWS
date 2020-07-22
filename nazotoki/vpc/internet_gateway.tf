resource "aws_internet_gateway" "nazotoki" {
  vpc_id = aws_vpc.nazotoki.id
} 