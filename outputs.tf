output "public_ip" {
  value = aws_instance.aws_instance.public_ip
}

output "backend_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}
output "frontend_repository_url" {
  value = aws_ecr_repository.frontend.repository_url
}
