resource "aws_db_instance" "postgres" {
  engine              = "postgres"
  engine_version      = "16.3"
  instance_class      = "db.${var.instance_type}"
  storage_type        = "gp2"
  allocated_storage   = 20
  db_name             = "devrate"
  username            = "devrate"
  password            = "devratedb"
  publicly_accessible = true
  skip_final_snapshot = true
  identifier          = "pg-devrete"
}