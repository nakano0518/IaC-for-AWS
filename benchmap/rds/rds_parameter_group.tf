# --------------------------------------------------
# MYSQLのmy.cnfファイルに定義するようなDBの設定を定義する。
# --------------------------------------------------

resource "aws_db_parameter_group" "benchmap-db-param" {
  name   = "benchmap-db-param"
  family = "mysql5.7"

  parameter {
    name  = "character_set_database"
    value = "utf8"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }
}