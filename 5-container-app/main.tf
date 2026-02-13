data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}

data "azurerm_container_app_environment" "env" {
  name                = var.container_environment
  resource_group_name = var.container_environment_rg
}

resource "azurerm_container_app" "app" {
  name                         = var.container_app_name
  container_app_environment_id = data.azurerm_container_app_environment.env.id
  resource_group_name          = data.azurerm_resource_group.rg.name
  revision_mode                = "Single"

  template {
    container {
      name   = var.container_app_name
      image  = var.container_image
      cpu    = 0.5
      memory = "1Gi"

      env {
        name  = "SPRING_PROFILES_ACTIVE"
        value = "dev"
      }
    }

    min_replicas = 0
    max_replicas = 1
  }

  ingress {
    external_enabled = true
    target_port      = 8080

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }
}
