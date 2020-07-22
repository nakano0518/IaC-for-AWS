resource "aws_subnet" "techbooklabov1_public_subnet_1" {
	vpc_id            = aws_vpc.techbooklabov1_vpc.id
	cidr_block        = "10.0.0.0/20"
	availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "techbooklabov1_public_subnet_2" {
	vpc_id            = aws_vpc.techbooklabov1_vpc.id
	cidr_block        = "10.0.16.0/20"
	availability_zone = "ap-northeast-1c"
}

resource "aws_subnet" "techbooklabov1_private_subnet_1" {
	vpc_id            = aws_vpc.techbooklabov1_vpc.id
	cidr_block        = "10.0.32.0/20"
	availability_zone = "ap-northeast-1a"
}

resource "aws_subnet" "techbooklabov1_private_subnet_2" {
	vpc_id            = aws_vpc.techbooklabov1_vpc.id
	cidr_block        = "10.0.48.0/20"
	availability_zone = "ap-northeast-1c"
}

# --------------------------------------------------------
# 各subnetのcidr_blockはかぶりのないように設定する。
# --------------------------------------------------------
# サブネットマスクは、20にしたので、前から20ビットマスク。
# 2進数表記すると、マスク部分は下記のようになる
# 11111111.11111111.11110000.00000000
# つまり、ネットワーク番号は、区切りの3つめまで、占める
# 区切りの3つめのマスクされていない部分は 4 bit
# つまり10進数に直すと、 2^4 = 16 ずつ(255まで)区切ることができる。
