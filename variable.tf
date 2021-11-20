variable "prefix" {
  type    = string
  default = "mls"
}


variable "tags" {
  type = map(string)
  default = {
    "environment"   = "Dev"
    "Owner"         = "Tej"
    "Business Unit" = "IT"
  }
}

variable "vm_size" {
  type    = string
  default = "Standard_B2ms"
}

variable "username" {
  type    = string
  default = "azureuser"
}
