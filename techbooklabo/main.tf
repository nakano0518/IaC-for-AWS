
##変数定義:variable -----------------------------------------------------------------------

variable "aws_access_key" {}  # 空の変数を定義
variable "aws_secret_key" {}  # 空の変数を定義

variable "aws_region" {
    default = "ap-northeast-1"  # デフォルトのリージョンを設定
}

variable "aws_db_username" {}　# 空の変数を定義
variable "aws_db_password" {}　# 空の変数を定義

variable "aws_key_name" {}　#空の変数を定義

# (重要) 空の変数を定義したものは、Terraformコマンド実行時にオプションとして「-var '変数名=値'」で渡す
#　　　　あるいは、terraform.tfvarsファイル(.gitignore!!!)を作成し記述しておくと、そのファイルが自動的に読み込まれる
## ----------------------------------------------------------------------------------------



##プロバイダーの設定 --------------------------------------------------------------------------

provider "aws" {
    access_key = "${var.aws_access_key}" #「var.変数名」で変数の参照
    secret_key = "${var.aws_secret_key}" #""内において${}で変数展開
    region     = "${var.aws_region}"
}

## ---------------------------------------------------------------------------------------








## --------------------------------------------------------------------------------------
## 以下、各種リソースの定義：定義方法は、resource "リソースの種類" "リソース名"{}
## リソースの種類は、プロバイダーがAWSの場合、接頭辞にaws_が付く。
## →VPCならaws_vpc、EC2ならaws_instance、RDSならaws_db_instance
## といったようにリソースの種類の名前がTerraform側で決められている。
## ---------------------------------------------------------------------------------------


## VPCの設定------------------------------------------------------------------------------
## Name tag:tf_vpc、 CIDRblock:10.0.0.0/16、 Tenancy:default(テナント属性はデフォルト)

resource "aws_vpc" "tf_vpc" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags {
        Name = "tf_vpc"
    }
}

## --------------------------------------------------------------------------------------



## Subnetの設定 --------------------------------------------------------------------------
## (1)EC2インスタンス(Webサーバー)、(2)RDSインスタンス(MySQL)、(3)RDS Multi-AZ構成用の3つ
## (1)Name tag:tf_public_web、 VPC:tf_vpc、AZ:ap-northeast-1a、CIDRblock:10.0.0.0/24
## (2)Name tag:tf_public_db1、 VPC:tf_vpc、AZ:ap-northeast-1a、CIDRblock:10.0.1.0/24
## (3)Name tag:tf_public_db2、 VPC:tf_vpc、AZ:ap-northeast-1c、CIDRblock:10.0.2.0/24

#(1)
resource "aws_subnet" "public_web" {
    vpc_id                  = "${aws_vpc.tf_vpc.id}"　#VPCIDは新規VPCが生成された際に決まるので変数展開で指定しておく。
    cidr_block              = "10.0.0.0/24"
    availability_zone       = "ap-northeast-1a"
    map_public_ip_on_launch = true
    tags {
        Name = "tf_public_web"
    }
}

#(2)
 resource "aws_subnet" "private_db1" {
    vpc_id            = "${aws_vpc.tf_vpc.id}"
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-northeast-1a"
    tags {
        Name = "tf_private_db1"
    }
}

#(3)
resource "aws_subnet" "private_db2" {
    vpc_id            = "${aws_vpc.tf_vpc.id}"
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-northeast-1c"
    tags {
        Name = "tf_private_db2"
    }
}

## --------------------------------------------------------------------------------------------------------



## Internet Gatewayの設定 ----------------------------------------------------------------------------------
##　VPCの指定とInternet Gatewayの名前を最低限指定しておけばOK

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.tf_vpc.id}"
    tags {
        Name = "tf-gw"
    }
}

## --------------------------------------------------------------------------------------------------------



## Route Tableの設定 ---------------------------------------------------------------------------------------
## (1)Route Table および (2)Route TableとSubnetを結び付けるブロックの2つを記述する
## WebサーバーとInternet GatewayのRoute Tableを作成

#(1)
resource "aws_route_table" "public_rtb" {
    vpc_id = "${aws_vpc.tf_vpc.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }
    tags {
        Name = "tf_rtb"
    }
}

#(2)

resource "aws_route_table_association" "public_a" {
    subnet_id      = "${aws_subnet.public_web.id}"
    route_table_id = "${aws_route_table.public_rtb.id}"
}

## ---------------------------------------------------------------------------------------------------------



## Security Group の設定 ------------------------------------------------------------------------------------

##(1)アプリケーションサーバー用Security Group設定値
## (基本設定) Nametag:tf_web、Groupname:tf_web、Description: (例)security group on web server、VPC:tf_vpc
## (インバウンドルール1) Type:SSH(22)、Protocol:TCP(6)、Port Range:22、Source:0.0.0.0/0
## (インバウンドルール1) Type:HTTP(80)、Protocol:TCP(6)、Port Range:80、Source:0.0.0.0/0
## (アウトバウンドルール) Type:All Traffic、Protocol:TCP(6)、Port Range:ALL(65535)、Source:0.0.0.0/0

# (基本設定)
resource "aws_security_group" "app" {
    name        = "tf_web"
    description = "security group on web server"
    vpc_id      = "${aws_vpc.tf_vpc.id}"
    tags {
        Name = "tf_web"
    }
}

# (インバウンド、アウトバウンドルール)
#アウトバウンドルールはマネジメントコンソールから入力する場合はデフォルトでALL Trafficな設定になるが、
#Terraformでは明示的に設定を記述しておかないといけない。
resource "aws_security_group_rule" "ssh" {
    type              = "ingress"
    from_port         = 22
    to_port           = 22
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group_rule" "web" {
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.app.id}"
}

resource "aws_security_group_rule" "all" {
    type              = "egress"
    from_port         = 0
    to_port           = 65535
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.app.id}"
}



##(2)データベースサーバー用Security Group設定値
## (基本設定) Nametag:tf_db、Groupname:tf_db、Description: (例)security group on db、VPC:tf_vpc
## (インバウンドルール) Type:MySQL(3306)、Protocol:TCP(6)、Port Range:3306、Source: dbサーバー用のSecurity GroupのID

# (基本設定)
resource "aws_security_group" "db" {
    name        = "db_server"
    description = "security group on db"
    vpc_id      = "${aws_vpc.tf_vpc.id}"
    tags {
        Name = "tf_db"
    }
}

# (インバウンドルール)
resource "aws_security_group_rule" "db" {
    type                     = "ingress"
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    source_security_group_id = "${aws_security_group.app.id}" # webサーバーからのアクセスを許可するため
    security_group_id        = "${aws_security_group.db.id}"
}

## -------------------------------------------------------------------------------------------------------



## DB Subnet Groupの設定 -----------------------------------------------------------------------------------
## RDSからVPCを利用するための設定

resource "aws_db_subnet_group" "main" {
    name        = "tf_dbsubnet"
    description = "It is a DB subnet group on tf_vpc."
    subnet_ids  = ["${aws_subnet.private_db1.id}", "${aws_subnet.private_db2.id}"]
    tags {
        Name = "tf_dbsubnet"
    }
}

## ---------------------------------------------------------------------------------------------------------


## DB serverの設定 ------------------------------------------------------------------------------------------
## マネジメントコンソールで入力する値を記述していけばよい

resource "aws_db_instance" "db" {
    identifier              = "tf_dbinstance"
    allocated_storage       = 5
    engine                  = "mysql"
    engine_version          = "5.6.27"
    instance_class          = "db.t1.micro"
    storage_type            = "gp2"
    username                = "${var.aws_db_username}" # variableブロックで変数定義
    password                = "${var.aws_db_password}" # variableブロックで変数定義
    backup_retention_period = 1
    vpc_security_group_ids  = ["${aws_security_group.db.id}"]
    db_subnet_group_name    = "${aws_db_subnet_group.main.name}"
}

## ------------------------------------------------------------------------------------------------------------


## アプリケーションサーバーの設定 --------------------------------------------------------------------------------------
## Amazon Linux AMI を t.microで使用する設定とする

resource "aws_instance" "web" {
    ami                         = "ami-374db956"  # 東京リージョンにあるAmazon Linux AMIのIDを指定する
    instance_type               = "t2.micro"
    key_name                    = "${var.aws_key_name}"  # EC2に登録済のKey Pairsを指定する、　variableブロックで変数定義
    vpc_security_group_ids      = ["${aws_security_group.app.id}"]
    subnet_id                   = "${aws_subnet.public_web.id}"
    associate_public_ip_address = "true"
    root_block_device = {
        volume_type = "gp2"
        volume_size = "20"
    }
    ebs_block_device = {
        device_name = "/dev/sdf"
        volume_type = "gp2"
        volume_size = "100"
    }
    tags {
        Name = "tf_instance"
    }
}


## -------------------------------------------------------------------------------------------------------------



## Elastic Ipの設定 ---------------------------------------------------------------------------------------------

resource "aws_eip" "web" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

## --------------------------------------------------------------------------------------------------------------
