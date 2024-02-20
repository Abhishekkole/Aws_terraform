# Create ECR repositories
resource "aws_ecr_repository" "repositories" {
  count = length(var.repository_names)
  name  = "${var.environment}-${var.repository_names[count.index]}"
  image_scanning_configuration {
    scan_on_push = true
  }
}