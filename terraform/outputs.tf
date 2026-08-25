output "container_name" {
  description = "Name of the provisioned web server container"
  value       = docker_container.web.name
}

output "web_url" {
  description = "URL of the Nginx web server"
  value       = "http://localhost:${var.host_port}"
}
