terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "RG-Terraform-Github-Actions-01"  
    storage_account_name = "stoterraformactions017"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# Gera uma senha aleatória forte para o admin da VM Windows
resource "random_password" "vm_admin_password" {
  length           = 16          # Tamanho recomendado (mínimo 12 para Azure)
  min_lower        = 1           # Pelo menos 1 letra minúscula
  min_upper        = 1           # Pelo menos 1 letra maiúscula
  min_numeric      = 1           # Pelo menos 1 número
  min_special      = 1           # Pelo menos 1 caractere especial
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}<>:?"  # Caracteres especiais permitidos (evita problemas com Azure)
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-VM-Terraform-Github-Actions-01"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-terraform-github-actions"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "snet-terraform-github-actions"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-terraform-github-actions"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-terraform-github-actions"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pip.id}"
  }
}

resource "azurerm_network_security_group" "nsg" {  
    name                = "nsg-terraform-github-actions"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    
    security_rule {
        name                       = "Allow-RDP"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"  # Porta RDP
        source_address_prefix      = "*"     # Permite de qualquer lugar (ajuste para mais segurança)
        destination_address_prefix = azurerm_network_interface.nic.private_ip_address
    }
}


resource "azurerm_windows_virtual_machine" "vm" {
  name                  = "vm-github-act"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B2s"
  admin_username        = "admin.betussi"
  admin_password        = random_password.vm_admin_password.result
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2025-Datacenter"    
    version   = "latest"
  }
  timezone    = "E. South America Standard Time"
}

output "vm_public_ip" {
  description = "IP público da VM para acessar via RDP"
  value       = azurerm_public_ip.pip.ip_address
}

output "admin_password" {
  description = "Senha gerada para a VM (sensível)"
  value       = random_password.vm_admin_password.result
  sensitive   = true
}