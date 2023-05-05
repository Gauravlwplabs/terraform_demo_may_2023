variable "name" {
  description = "Name the instance on deploy"
  type        = string
  default     = "web-server"
}
variable "key_name" {
  description = "Name the key_name"
  type        = string
  default     = "ostest"
}
variable "vpc_name" {
  description = "Name the vpc_name"
  type        = string
  default     = "vpc-05ccb69fbbb86d17c"
}