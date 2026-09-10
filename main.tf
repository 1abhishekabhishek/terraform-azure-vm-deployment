resource "azurerm_resource_group" "abhivm001" {
  name     = "abhidemo001"
  location = "Central India"

}

#Now creating azure Virtual network VNET

resource "azurerm_virtual_network" "abhivnet001" {
  name                = "abhivnetdemo001"
  resource_group_name = azurerm_resource_group.abhivm001.name
  location            = azurerm_resource_group.abhivm001.location
  address_space       = ["10.0.0.0/16"]
}

#Now creating azurerm subnet

resource "azurerm_subnet" "abhisubnet001" {
  name                 = "abhisubnet001"
  resource_group_name  = azurerm_resource_group.abhivm001.name
  virtual_network_name = azurerm_virtual_network.abhivnet001.name
  address_prefixes     = ["10.0.1.0/24"]

}

#now creating azurerm Network security group

resource "azurerm_network_security_group" "abhinsg001" {
  name                = "abhinsg001"
  location            = azurerm_resource_group.abhivm001.location
  resource_group_name = azurerm_resource_group.abhivm001.name

}

#Now creating Public Ip

resource "azurerm_public_ip" "abhipublicly" {
  name                = "abhipublic001"
  location            = azurerm_network_security_group.abhinsg001.location
  resource_group_name = azurerm_resource_group.abhivm001.name
  allocation_method   = "Static"

}

#now creating NIC

resource "azurerm_network_interface" "abhinic" {
  name                = "abhinic001"
  location            = azurerm_resource_group.abhivm001.location
  resource_group_name = azurerm_resource_group.abhivm001.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.abhisubnet001.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.abhipublicly.id

  }

}

#Now associating NIC with NSG

resource "azurerm_network_interface_security_group_association" "abhinic_nsg" {
  network_interface_id      = azurerm_network_interface.abhinic.id
  network_security_group_id = azurerm_network_security_group.abhinsg001.id

}

# Now creating Windows VM

resource "azurerm_windows_virtual_machine" "abhifirstvm" {
  name                = "firstvm001"
  location            = azurerm_resource_group.abhivm001.location
  resource_group_name = azurerm_resource_group.abhivm001.name
  size                = "Standard_B2s"

  admin_username = "azureadmin"
  admin_password = "Password@12345!"

  network_interface_ids = [
    azurerm_network_interface.abhinic001.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}
