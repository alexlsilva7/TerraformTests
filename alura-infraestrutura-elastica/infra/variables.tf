variable "regiao_aws" {
  type = string
}

variable "chave" {
    type = string
}

variable "instancia" {
    type = string  
}

variable "security_group_name" {
  type = string
}

variable "auto_scaling_group_name" {
  type = string
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "producao" {
  type = bool
  default = false
}