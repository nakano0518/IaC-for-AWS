data "template_file" "service_container_definition" {
	template = file("./container_definitions/service.json")
	vars = {
		app_key 					= var.app_key 
		app_url 					= var.app_url
		db_host 					= var.db_host
		db_database 				= var.db_database
		db_username 				= var.db_username
		db_password 				= var.db_password
		rakuten_access_url 			= var.rakuten_access_url
		rakuten_application_id 		= var.rakuten_application_id
		rakuten_application_secret 	= var.rakuten_application_secret
		rakuten_affiliate_id 		= var.rakuten_affiliate_id
	}
}
resource "aws_ecs_task_definition" "techbooklabov1_task" {
	family                = "techbooklabov1-service"
	container_definitions = data.template_file.service_container_definition.rendered
	task_role_arn         = data.terraform_remote_state.aws_iam.outputs.ecs_task_role_arn
	network_mode          = "bridge"
}







data "template_file" "migration_container_definition" {
	template = file("./container_definitions/migration.json.tpl")
	vars = {
		app_key 					= var.app_key 
		app_url 					= var.app_url
		db_host 					= var.db_host
		db_database 				= var.db_database
		db_username 				= var.db_username
		db_password 				= var.db_password
	}
}
resource "aws_ecs_task_definition" "techbooklabov1-db-migrate" {
	family                = "techbooklabov1-db-migrate"
	container_definitions = data.template_file.migration_container_definition.rendered
	execution_role_arn    = data.terraform_remote_state.aws_iam.outputs.ecs_task_role_arn
	network_mode          = "bridge"
}