variable "rgname" {
        type = string
        description = "Used for naming Resource group"

  
}

variable "rglocation" {
        type = string
        description = "Used for selecting location of Resource group"
        default = "East US"
}

# variable "prefix" {
#         type = string
#         description = "Used to determine standard prefix for all resources"
# }

variable "vnetname" {
        type = string
        description = "This variable define addres sapce for virtual network"
}

variable "subnetname" {
        type = string
        description = "this variable defaine address sapce for subnet"
}

variable "vnet_cidr" {
        type = string
        description = "This variable define addres sapce for virtual network"
}   

variable "subnet_cidr" {
        type = string
        description = "this variable defaine address sapce for subnet"
}


  
