resource "aws_ecr_repository" "Create-ECR" {
  name                 = var.back_rep_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true
}

resource "aws_ecr_lifecycle_policy" "default_policy" {
  repository = var.back_rep_name

  policy = <<EOF
	{
	    "rules": [
	        {
	            "rulePriority": 1,
	            "description": "Keep only the last ${var.untagged_images} untagged images.",
	            "selection": {
	                "tagStatus": "untagged",
	                "countType": "imageCountMoreThan",
	                "countNumber": ${var.untagged_images}
	            },
	            "action": {
	                "type": "expire"
	            }
	        }
	    ]
	}
	EOF

  depends_on = [aws_ecr_repository.Create-ECR]
}

