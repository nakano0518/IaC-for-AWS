# -------------------------------------------------------------------------
# 本リソースを削除・変更する際は、事前に(＊)の操作をする必要がある
# -------------------------------------------------------)------------------

variable name {}
variable password {}
variable dbname {}

resource "aws_db_instance" "rds" {

  # DBのエンドポイントで使う識別子の設定
  identifier = "benchmap"

  # DBエンジン名
  engine = "mysql"

  # 5.7.23の「.23」まで指定する必要がある	
  engine_version = "5.7.23"

  # インスタンスクラス
  instance_class = "db.t2.micro"

  # ストレージ割り当て：最小20GiB
  allocated_storage = 20

  # ストレージタイプ：gp2は「汎用SSD」を意味する
  storage_type = "gp2"

  # ストレージの暗号化の有効化(db.t2.microではサポートないので指定しない)
  # storage_encrypted        = true

  # DB名
  name = var.dbname

  # ユーザー名
  username = var.name

  # パスワード: 以降でignore_changesに[password]を設定している。terraform applyした後、NEW_PASSWORD部分に新しいパスワードを入れたうえで下記コマンドを実行し変更できるので変更する。
  # aws rds modify-db-instance --db-instance-identifier 'techbooklabo-v1' --master-user-password 'NEW_PASSWORD'
  # 今回は上記の方法ではなく、terraform.tfvarsに変数と値を記述し(.gitignoreし)、本ファイルでその変数を読み込む方法を採用してみる。
  password = var.password

  # RDSインスタンスが Multi-AZ なら指定する
  multi_az = true

  # VPC外からの接続を遮断
  publicly_accessible = false

  # 自動バックアップが作成される時間帯をUTCで指定。maintenabce_windowと時間帯が重なってはならない。
  backup_window = "09:10-09:40"

  # バックアップが保持される日数
  backup_retention_period = 30

  # メンテナンス(OS、DBの更新)のタイミングの設定をUTCで指定。メンテナンスの無効化は不可。
  maintenance_window = "mon:10:10-mon:10:40"

  # 自動マイナーバージョンアップは無効化できる。
  auto_minor_version_upgrade = false

  # (＊) trueにするとDBは削除できない(削除保護)。デフォルトはfalse。terraformコマンドで削除したい場合、この項目をfalseにしてapplyしてからdestroyする。また、本ファイルの項目を変更したい場合も一度この項目をfalseにしてapplyしてから、変更しapplyする。
  deletion_protection = false

  # (＊) 削除時snapshotをスキップしない(false)。terraformコマンドで削除したい場合、この項目をtrueにしてapplyしてからdestroyする。また、本ファイルの項目を変更したい場合も	一度この項目をtrueにしてapplyしてから、変更しapplyする。
  skip_final_snapshot = true

  # ポート
  port = 3306

  # 設定変更のタイミング。即時反映せずメンテナンスウィンドウ時に変更(false)。設定変更時に再起動を伴うものもあり、ダウンタイムが発生する可能性があるから。
  apply_immediately = false


  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_db_id]
  parameter_group_name   = aws_db_parameter_group.benchmap-db-param.name
  option_group_name      = aws_db_option_group.benchmap-db-option.name
  db_subnet_group_name = aws_db_subnet_group.dbsubnet.name
  
  lifecycle {
    ignore_changes = [password]
  }
}

