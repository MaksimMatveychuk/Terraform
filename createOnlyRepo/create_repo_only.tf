provider "aws" {}

resource "aws_ecr_repository" "tech_task_repo" {
  name                 = "tf_example_repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "default_policy" {
  repository = aws_ecr_repository.tech_task_repo.name

  policy = <<EOF
	{
	    "rules": [
	        {
	            "rulePriority": 1,
	            "description": "Keep only the last 2 untagged images.",
	            "selection": {
	                "tagStatus": "untagged",
	                "countType": "imageCountMoreThan",
	                "countNumber": 2
	            },
	            "action": {
	                "type": "expire"
	            }
	        }
	    ]
	}
	EOF

  depends_on = [aws_ecr_repository.tech_task_repo]
}