resource "aws_ecr_repository" "batch" {
  name                 = "batch-test"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}