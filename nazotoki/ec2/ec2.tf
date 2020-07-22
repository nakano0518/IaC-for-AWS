# ----------------------------------------------------
#	削除保護設定
# -----------------------------------------------------


# 最新の Amazon Linux2 のAMIを取得する
data "aws_ami" "recent_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

# ec2インスタンス定義
resource "aws_instance" "app" {
  ami           = data.aws_ami.recent_amazon_linux_2.image_id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.app.id

  associate_public_ip_address = true  # 自動割り当てパブリックIP:有効化
  monitoring                  = false # モニタリング:なし

  subnet_id = data.terraform_remote_state.vpc.outputs.public_subnet_1_id

  vpc_security_group_ids = [
    data.terraform_remote_state.vpc.outputs.security_group_app_id
  ]
  # EC2の管理に役立つ特別なディレクトリと構成ファイルが格納(windowsでいうCドライブ)
  # volume_typeで汎用SSDを指定
  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
  }

  # 削除保護 (terraform destroy でエラーが出るようにする)
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "nazotoki"
  }

}

# ElasticIPの設定
resource "aws_eip" "app" {
  instance = aws_instance.app.id
  vpc      = true
}

# keypair
resource "aws_key_pair" "app" {
  key_name   = "app"
  public_key = file("./id_rsa.pub") # 公開鍵を指定
}