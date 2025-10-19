resource "aws_ecr_repository" "ecr_website" {
  name                 = "prod"
  image_tag_mutability = "MUTABLE"
}