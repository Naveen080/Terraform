provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}

# terraform {
#    # backend "azurerm" {}
#    backend "local" {
#     path = "/Users/ee211312/Documents/PLM-doc/doc-tf/app-service/terraform.tfstate"
#   }
# }