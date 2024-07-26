resource "null_resource" "docker_image" {

  provisioner "local-exec" {
    working_dir = "/home/runner/work/Terraform/Terraform/backend"
    command     = <<EOF
aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com && cd /home/runner/work/Terraform/Terraform/backend && chmod +x ./mvnw && ./mvnw clean package && docker build -t ${var.back_rep_name} . && docker tag ${var.back_rep_name}:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.back_rep_name}:latest && docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.back_rep_name}:latest
    EOF
  }

  triggers = {
    "run_at" = timestamp()
  }

}