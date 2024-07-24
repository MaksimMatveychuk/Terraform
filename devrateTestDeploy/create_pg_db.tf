resource "aws_db_instance" "postgres" {
  engine               = "postgres"
  identifier           = "postgres"
  allocated_storage    =  20
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  username             = "postgres"
  password             = "postgres"
  skip_final_snapshot  = true
  publicly_accessible =  true
  storage_type      = "gp2"
  db_name = "postgres"
}