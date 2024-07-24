resource "null_resource" "docker_packaging" {

  provisioner "local-exec" {
    working_dir = "D:/Java/DevRate/devrate-service"
    command     = <<-EOF
        aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-north-1.amazonaws.com && mvn clean install && docker build -t backrepository . && docker tag backrepository:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-north-1.amazonaws.com/backrepository:latest && docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.eu-north-1.amazonaws.com/backrepository:latest
	    EOF
  }

  triggers = {
    "run_at" = timestamp()
  }

  depends_on = [
    aws_ecr_repository.Create-ECR,
  ]
}