
# --------------------------------------------------------------
# vpc で 10.0.0.0/16 を指定(第2オクテットまでなのでわかりやすいので)
# つまり、vpc 全体で、10.0.0.0 ～ 10.0.255.255 まで使用できるということ。
# その中で、サブネットに分割する。
# なぜなら、サブネットごとに異なる availability_zone を指定することができるから。
# --------------------------------------------------------------

# 1つ目のサブネットは、10.0.0.0/24とする。(第3オクテットまででわかりやすいので)
# 10.0.0.0～10.0.0.255 までが割り当てられる。 
resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.benchmap.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "benchmap_public_1"
  }
}

# (10.0.0.0 ～ 10.0.0.255までは既に使用したので、)
# 2つ目のサブネットは、10.0.1.0～を割り当てる
resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.benchmap.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "benchmap_public_2"
  }
}

# (10.0.1.0 ～ 10.0.1.255までは既に使用したので、)
# 3つ目のサブネットは、10.0.2.0～を割り当てる
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.benchmap.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "benchmap_private_1"
  }
}

# (10.0.2.0 ～ 10.0.2.255までは既に使用したので、)
# 4つ目のサブネットは、10.0.3.0～を割り当てる
resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.benchmap.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "benchmap_private_2"
  }
}