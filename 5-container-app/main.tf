data "azurerm_resource_group" "rg" {
  name = var.RESOURCE_GROUP_NAME
}

data "azurerm_container_app_environment" "env" {
  name                = var.CONTAINER_ENVIRONMENT
  resource_group_name = var.CONTAINER_ENVIRONMENT_RG
}

locals {
  env_map = jsondecode(file("${path.module}/config.json"))
}


resource "azurerm_container_app" "app" {
  name                         = var.CONTAINER_APP_NAME
  container_app_environment_id = data.azurerm_container_app_environment.env.id
  resource_group_name          = data.azurerm_resource_group.rg.name
  revision_mode                = "Single"

  

  identity {
    type = "SystemAssigned"
  }
  

  template {
    container {
      name   = var.CONTAINER_APP_NAME
      image  = var.CONTAINER_IMAGE
      cpu    = 0.5
      memory = "0.5Gi"

      dynamic "env" {
        for_each = local.env_map
        content {
          name  = env.key
          value = env.value
        }
      }
    }

    min_replicas = 1
    max_replicas = 2
  }

  ingress {
    #cors { allowed_origins = ["*"] }

    external_enabled = false
    target_port      = 8080

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
