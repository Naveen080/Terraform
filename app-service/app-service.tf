#terraform init
#terraform plan
#terraform import azurerm_resource_group.example /subscriptions/5ff1bcc2-7e3f-46dc-b3ce-2d09a5f63fa6/resourceGroups/aks-test
#terraform apply
resource "azurerm_resource_group" "example" {
  name     = "aks-test"
  location = "East US"
}

resource "azurerm_app_service_plan" "example" {
  name                = "tltest-asp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Windows"
  is_xenon            = false
  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "example" {
  name                = "tltest-app"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    #The portal and az cli list "8.10" as the supported version.
    #"8.10" doesn't work here!
    #"8.10.0" is the version installed in D:\Program Files (x86)\nodejs
    "WEBSITE_NODE_DEFAULT_VERSION" = "12-lts"
  }

}

# module "web_app" {
#   source = "innovationnorway/web-app/azurerm"

#   name = "akstltest"
  
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name

#   plan = {
#     id = azurerm_app_service_plan.example.id
#     sku_size = "B1"

#   }

#   runtime = {
#     name    = "node"
#     version = "12-lts"
#   }
# }