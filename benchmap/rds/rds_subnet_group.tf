resource "aws_db_subnet_group" "dbsubnet" {
	name       = "benchmap-dbsubnet"
	subnet_ids = [
		data.terraform_remote_state.vpc.outputs.private_subnet_1_id,
		data.terraform_remote_state.vpc.outputs.private_subnet_2_id
	]
}