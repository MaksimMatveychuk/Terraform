resource "null_resource" "docker_image" {

  provisioner "local-exec" {
    working_dir = var.work_directory
    command     = <<-EOF
    aws ecr get-login-password --region ${var.region} | docker login \
    --username AWS \
    --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com && \
    cd ${var.work_directory} && \
    chmod +x ./mvnw && \
    ./mvnw clean package && \
    docker build -t ${var.back_repository_name} . && \
    docker tag ${var.back_repository_name}:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.back_repository_name}:latest && \
    docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.back_repository_name}:latest
    EOF
  }

  triggers = {
    "run_at" = timestamp()
  }

}