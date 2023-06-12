variable "region" {
  type        = string
  description = "Regiao"
  default     = "us-east-1"

}

variable "ami" {
  type        = string
  description = "Idenficacao da maquina"
  default     = "ami-053b0d53c279acc90"

}

variable "instance_type" {
  type        = string
  description = "Tamanho da instancia"
  default     = "t2.micro"

}

variable "user_ssh" {
  type        = string
  description = "Usuario SSH"
  default     = "ec2-user"

}