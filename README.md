# PostgreSQL for Hasura

In short, this should make it easy to set up a database you can use in a Hasura project.

With more jargon: A Terraform module for setting up Aurora Serverless PostgreSQL databases in AWS RDS. See [Resources](#resources) for help with the jargon.

## Use

All you need is

- your Hasura project's IP address
- whatever you'd like your database password to be
- the AWS VPC ID you'd like your database to live in

Check out this example:

```
# Set up our providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-west-1"
}

# Here we're just grabbing the default VPC for our AWS account
resource "aws_default_vpc" "default" {

}

# Use the module
module "postgresql-for-hasura" {
  source  = "crismali/postgresql-for-hasura/aws"
  version = "~> 0.0.6"

  # This will be the password to our database and should probably be kept secret
  database_password = var.database_password # ie "some-password-for-the-database"

  # This is where we pass in the IP address of our Hasura project.
  # Without this Hasura won't be able to connect to the database.
  hasura_ip_address = "0.0.0.0/32"

  # The ID of our preferred VPC. Here we're grabbing the ID of our AWS account's default VPC.
  vpc_id = aws_default_vpc.default.id
}

# Not required but convenient.
# `terraform output -raw endpoint | pbcopy` to copy your database URL so you can just paste it into Hasura.
output "endpoint" {
  sensitive = true
  value     = module.postgresql-for-hasura.postgresql_for_hasura_database_url
}
```

## Resources

- [Aurora Serverless](https://aws.amazon.com/rds/aurora/serverless/)
- [Aurora](https://aws.amazon.com/rds/aurora/)
- [AWS RDS](https://aws.amazon.com/rds/)
- [AWS](https://aws.amazon.com/)
- [PostgreSQL](https://www.postgresql.org/)
- [Serverless](https://aws.amazon.com/serverless/)
- [Terraform](https://www.terraform.io/)
- [Terraform Registry](https://registry.terraform.io/) - where you can find modules

## Code of Conduct

[Follow it.](CODE_OF_CONDUCT.md)
