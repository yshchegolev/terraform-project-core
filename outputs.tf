//output "ips" {
//  value = azurerm_linux_virtual_machine.vm.*.public_ip_address
//}
output "vm_ips" {
  description = "Public IPs of created VMs"
  value       = module.vms.*.vm_ip
}