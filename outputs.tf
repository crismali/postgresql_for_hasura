output "postgresql_for_hasura_database_endpoint" {
  description = "The database cluster endpoint."
  sensitive   = false
  value       = aws_rds_cluster.cluster.endpoint
}

output "postgresql_for_hasura_database_url" {
  description = "The complete database URL you can paste into Hasura. `terraform output -raw postgresql_for_hasura_database_url | pbcopy`"
  sensitive   = true
  value       = "postgresql://${var.database_username}:${var.database_password}@${aws_rds_cluster.cluster.endpoint}:5432/${var.database_name}"
}

output "postgresql_for_hasura_passwordless_database_url" {
  description = "A valid database URL with 'REPLACE_WITH_PASSWORD' instead of your database's password."
  sensitive   = false
  value       = "postgresql://${var.database_username}:REPLACE_WITH_PASSWORD@${aws_rds_cluster.cluster.endpoint}:5432/${var.database_name}"
}
