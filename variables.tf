variable "project_tags" {
  description = "Tags for project"
  type        = map(string)
  default = {
    tag1 = "tag1"
  }
}
variable "project_location" {
  description = "AZURE location for project"
  type        = string
  default     = "West Europe"
}
variable "project_name" {
  description = "Name of a project"
  type        = string
  default     = "my_project"
}
variable "network_address_space" {
  description = "Address space to use in project network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}
variable "subnet_address_prefixes" {
  description = "Address prefixes to use with subnet in project network"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}
variable "private_ips_allocation_type" {
  description = "Private IPs allocation type"
  type        = string
  default     = "Dynamic"
}
variable "public_ip_allocation_type" {
  description = "Public IP allocation type"
  type        = string
  default     = "Static"
}
variable "vm_number" {
  description = "Number of instances to create"
  type        = number
  default     = 1
}
#VMs settings
variable "vms_size" {
  description = "VM size according to AZURE sizing"
  type        = string
  default     = "Standard_B2ms"
}
variable "vm_admin_user" {
  description = "VMs admin user"
  type        = string
  default     = "ubuntu"
}
variable "vm_ssh_key_path" {
  description = "Path to public SSH key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
variable "vm_disk_settings" {
  description = "VMs disk settings"
  type        = map(string)
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}
variable "vm_image_settings" {
  description = "Base image for VMs"
  type        = map(string)
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "20.04.202006100"
  }
}