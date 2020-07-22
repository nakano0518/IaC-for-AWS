# ---------------------------------------------------------------------------------
# DBオプショングループ：DBにオプション機能を追加。
# 
# MySQLでは、「MARIADB監査プラグイン」および「MySQL MEMCACHED」が選択可能。
# 下記では「MARIADB監査プラグイン」を選択する。ユーザーのログオン、実行されたクエリなどの情報が記録される
# ---------------------------------------------------------------------------------

resource "aws_db_option_group" "techbooklabov1-db-option" {
	name = "techbooklabov1-db-option"
	engine_name = "mysql"
	major_engine_version = "5.7"

	option {
		option_name = "MARIADB_AUDIT_PLUGIN"
	}
}