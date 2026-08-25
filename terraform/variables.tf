variable "container_name" {
  description = "Name of the web server container"
  type        = string
  default     = "week6-web-server"
}

variable "host_port" {
  description = "Host port mapped to Nginx"
  type        = number
  default     = 8080
}
