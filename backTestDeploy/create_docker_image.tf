resource "null_resource" "docker_image" {

  provisioner "local-exec" {
    working_dir = "D:/Java/DevRate/devrate-service"
    command     = <<EOF
aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com && docker build -t ${var.back_rep_name} . && docker tag ${var.back_rep_name}:latest ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.back_rep_name}:latest && docker push ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${var.back_rep_name}:latest
    EOF
  }

  triggers = {
    "run_at" = timestamp()
  }

}