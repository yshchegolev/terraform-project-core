resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project_name}-vnet"
  address_space       = var.network_address_space
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name
  tags                = var.project_tags
}

resource "azurerm_subnet" "subnet_in_vnet" {
  name                 = "${var.project_name}-subnet"
  address_prefixes     = var.subnet_address_prefixes
  resource_group_name  = module.resource_group.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_interface" "net_interface" {
  count               = var.vm_number
  name                = "${var.project_name}-net-iface-${count.index}"
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name

  ip_configuration {
    name                          = "${var.project_name}-internal-ip-conf"
    subnet_id                     = azurerm_subnet.subnet_in_vnet.id
    private_ip_address_allocation = var.private_ips_allocation_type
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
  tags = var.project_tags
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.vm_number
  name                = "${var.project_name}-public-ip-${count.index}"
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name
  allocation_method   = var.public_ip_allocation_type
  tags                = var.project_tags
}

resource "azurerm_network_security_group" "net_sg" {
  name                = "${var.project_name}-net-sg"
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name

  security_rule {
    name                       = "${var.project_name}-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "${var.project_name}-grafana"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "3000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "${var.project_name}-prometheus"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "9090"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "${var.project_name}-pushgateway"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "9091"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.project_tags
}

resource "azurerm_subnet_network_security_group_association" "sg_to_net" {
  subnet_id                 = azurerm_subnet.subnet_in_vnet.id
  network_security_group_id = azurerm_network_security_group.net_sg.id
}