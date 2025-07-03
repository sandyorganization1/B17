variable "nsg_name" {
    type = string
}
variable "resource_group_name" {
    type = string  
}
variable "location" {
   type = string
}
variable "security_rule" {
   type = string
}
variable "destination_port_ranges" {
    type = list(string)
}