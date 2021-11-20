#Creating variable to make the code more dynamic

# Variable with reference to the project name
variable "environment" {
  type    = string
  default = "mls"
}

# Varaible for tags
variable "tags" {
  type = map(string)
  default = {
    "environment"   = "Dev"
    "Owner"         = "Tej"
    "Business Unit" = "IT"
  }
}

# Variable for VM Size
variable "vm_size" {
  type    = string
  default = "Standard_b2ms"
}

# Variables for username and password
variable "username" {
  type    = string
  default = "azureuser"
}

variable "password" {
  type = string
  default = "P@ssw0rd@123"
}


# Variables for VM Names
variable "bastionvm_name" {
  type = string
  default = "bastion-vm"
}


variable "webvm_name" {
  type = string
  default = "web-vm"
}

variable "appvm_name" {
  type = string
  default = "app-vm"
}


# Variable for Virtual Network
variable "vnet" {
  type = string
  default = "vnet"
}


#Creating variables for subnets
variable "bstn-sub" {
  type = string
  default = "bastion-subnet"
}

variable "web-sub" {
  type = string
  default = "web-subnet"
}

variable "app-sub" {
  type = string
  default = "app-subnet"
}


# Variable for IP Addresses for VNET and Subnets

variable "vnet_add" {
  type = list(string)
  default = [ "10.20.0.0/16" , "10.30.0.0/16" ]
}

variable "bstn_add" {
  type = list(string)
  default = ["10.20.1.0/24"]
}

variable "web_add" {
  type = list(string)
  default = ["10.30.1.0/24"]
}

variable "app_add" {
  type = list(string)
  default = ["10.30.2.0/24"]
}


# Variables for Network Security Group Names

variable "bstnnsg" {
  type = string
  default = "bastion-nsg"
}

variable "webnsg" {
  type = string
  default = "web-nsg"
}

variable "appnsg" {
  type = string
  default = "app-nsg"
}

# Variable for local Public IP
variable "local_pip" {
  type = string
  default = "49.206.55.34"
  description = "Please provide you local machine public IP address above"
}

# Variables for VM Public IP's
variable "bstn_pip" {
  type = string
  default = "bastion-pip"
}

variable "web_pip" {
  type = string
  default = "web-pip"
}

# Variables for Network Interface Cards
variable "bstn_nic" {
  type = string
  default = "bastion-nic"
}

variable "web_nic" {
  type = string
  default = "web-nic"
}

variable "app_nic" {
  type = string
  default = "app-nic"
}