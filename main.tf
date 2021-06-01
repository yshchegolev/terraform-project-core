module "resource_group" {
  source       = "git@github.com:yshchegolev/terraform-module-az-rg.git"
  rg_name      = "${var.project_name}-rg"
  rg_location  = var.project_location
  project_tags = var.project_tags
}
module "vms" {
  source            = "git@github.com:yshchegolev/terraform-module-az-vm.git"
  count             = var.vm_number
  vm_name           = "${var.project_name}-vm-${count.index}"
  rg_location       = module.resource_group.rg_location
  rg_name           = module.resource_group.rg_name
  vm_admin_user     = var.vm_admin_user
  vm_image_settings = var.vm_image_settings
  vm_disk_settings  = var.vm_disk_settings
  vms_size          = var.vms_size
  vm_ssh_key_path   = var.vm_ssh_key_path
  interface_ids     = azurerm_network_interface.net_interface[count.index].id
  vm_tags           = var.project_tags
}

resource "null_resource" "ansible-roles" {
  provisioner "local-exec" {
    command = "ansible-galaxy install -r requirements.yml --roles-path roles"
  }
}
resource "null_resource" "ansible-playbook" {
  count = var.vm_number
  provisioner "local-exec" {
    command = "sleep 120 && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -e application_project_name=${var.project_name} -i ${module.vms[count.index].vm_ip}, playbook.yml -u ubuntu --vault-password-file password.file"
  }
}