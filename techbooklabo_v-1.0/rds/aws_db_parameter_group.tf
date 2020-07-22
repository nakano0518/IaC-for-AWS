# --------------------------------------------------
# MYSQLのmy.cnfファイルに定義するようなDBの設定を定義する。
# --------------------------------------------------

resource "aws_db_parameter_group" "techbooklabov1-db-param"{
	name = "techbooklabov1-db-param"
	family = "mysql5.7"

	parameter {
		name = "character_set_database"
		value = "utf8"
	}

	parameter {
		name = "character_set_server"
		value = "utf8"
	}
}