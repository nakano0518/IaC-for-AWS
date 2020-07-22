resource "aws_internet_gateway" "benchmap" {
  vpc_id = aws_vpc.benchmap.id
} 