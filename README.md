## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =2.46.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =2.46.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | git@github.com:yshchegolev/terraform-module-az-rg.git | n/a |
| <a name="module_vms"></a> [vms](#module\_vms) | git@github.com:yshchegolev/terraform-module-az-vm.git | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_interface.net_interface](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_interface) | resource |
| [azurerm_network_security_group.net_sg](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/network_security_group) | resource |
| [azurerm_public_ip.public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/public_ip) | resource |
| [azurerm_subnet.subnet_in_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.sg_to_net](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/2.46.0/docs/resources/virtual_network) | resource |
| [null_resource.ansible-playbook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.ansible-roles](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_address_space"></a> [network\_address\_space](#input\_network\_address\_space) | Address space to use in project network | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_private_ips_allocation_type"></a> [private\_ips\_allocation\_type](#input\_private\_ips\_allocation\_type) | Private IPs allocation type | `string` | `"Dynamic"` | no |
| <a name="input_project_location"></a> [project\_location](#input\_project\_location) | AZURE location for project | `string` | `"West Europe"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of a project | `string` | `"my_project"` | no |
| <a name="input_project_tags"></a> [project\_tags](#input\_project\_tags) | Tags for project | `map(string)` | <pre>{<br>  "tag1": "tag1"<br>}</pre> | no |
| <a name="input_public_ip_allocation_type"></a> [public\_ip\_allocation\_type](#input\_public\_ip\_allocation\_type) | Public IP allocation type | `string` | `"Static"` | no |
| <a name="input_subnet_address_prefixes"></a> [subnet\_address\_prefixes](#input\_subnet\_address\_prefixes) | Address prefixes to use with subnet in project network | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_vm_admin_user"></a> [vm\_admin\_user](#input\_vm\_admin\_user) | VMs admin user | `string` | `"ubuntu"` | no |
| <a name="input_vm_disk_settings"></a> [vm\_disk\_settings](#input\_vm\_disk\_settings) | VMs disk settings | `map(string)` | <pre>{<br>  "caching": "ReadWrite",<br>  "storage_account_type": "Standard_LRS"<br>}</pre> | no |
| <a name="input_vm_image_settings"></a> [vm\_image\_settings](#input\_vm\_image\_settings) | Base image for VMs | `map(string)` | <pre>{<br>  "offer": "0001-com-ubuntu-server-focal",<br>  "publisher": "Canonical",<br>  "sku": "20_04-lts",<br>  "version": "20.04.202006100"<br>}</pre> | no |
| <a name="input_vm_number"></a> [vm\_number](#input\_vm\_number) | Number of instances to create | `number` | `1` | no |
| <a name="input_vm_ssh_key_path"></a> [vm\_ssh\_key\_path](#input\_vm\_ssh\_key\_path) | Path to public SSH key | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_vms_size"></a> [vms\_size](#input\_vms\_size) | VM size according to AZURE sizing | `string` | `"Standard_B2ms"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_ips"></a> [vm\_ips](#output\_vm\_ips) | Public IPs of created VMs |
