variable "apply_immediately" {
  description = "Whether or not changes should happen immediately or during the next maintenance window. May result in downtime."
  default     = false
  nullable    = false
  type        = bool
}

variable "cluster_identifier" {
  description = "The RDS Cluster Identifier. Will use generated label ID if not supplied"
  default     = ""
  nullable    = false
  type        = string
}

variable "database_name" {
  default     = "hasura"
  description = "Whatever you want your database to be called. Once you build a database url this will be at the end ie postgresql://.../database_name_you_chose"
  nullable    = false
  type        = string
}

variable "database_password" {
  description = "The password to your database. This should be something that won't break a database URL."
  nullable    = false
  type        = string
}

variable "database_username" {
  default     = "postgres"
  description = "The name of your database's main user. This should be something that won't break a database URL."
  nullable    = false
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine to use. See `aws rds describe-db-engine-versions`. (If you have `jq` installed run `aws rds describe-db-engine-versions | jq '.DBEngineVersions[] | select(.Engine == \"aurora-postgresql\") | .EngineVersion'`)"
  default     = "14.3"
  nullable    = false
  type        = string
}

variable "hasura_ip_address" {
  description = "The IP address associated with your Hasura project"
  nullable    = false
  type        = string
}

variable "instance_identifier" {
  description = "The RDS Instance Identifier. Will use generated label ID if not supplied"
  default     = ""
  nullable    = false
  type        = string
}

variable "security_group_name" {
  description = "The name of the security group that only allows requests/connections from Hasura."
  default     = "postgresql_for_hasura_security_group"
  nullable    = false
  type        = string
}

variable "serverless_scaling_max_capacity" {
  description = "The maximum capacity for an Aurora DB cluster in provisioned DB engine mode. The maximum capacity must be greater than or equal to the minimum capacity. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5"
  default     = 1.0
  nullable    = false
  type        = number
}

variable "serverless_scaling_min_capacity" {
  description = "The minimum capacity for an Aurora DB cluster in provisioned DB engine mode. The minimum capacity must be lesser than or equal to the maximum capacity. Valid capacity values are in a range of 0.5 up to 128 in steps of 0.5"
  default     = 0.5
  nullable    = false
  type        = number
}

variable "vpc_id" {
  description = "The ID of the VPC you want your resources to be created in"
  nullable    = false
  type        = string
}
