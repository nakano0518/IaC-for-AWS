resource "aws_route_table" "public" {
  vpc_id = aws_vpc.benchmap.id
}