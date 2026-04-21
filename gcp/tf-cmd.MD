## Comandos de Terraform

### Comandos principales

| Comando | Descripción |
|--------|-------------|
| `terraform init` | Inicializa el directorio de trabajo, descarga providers y módulos |
| `terraform plan` | Muestra los cambios que se aplicarán sin ejecutarlos |
| `terraform apply` | Aplica los cambios definidos en la configuración |
| `terraform destroy` | Destruye toda la infraestructura gestionada |

### Inspección y formato

| Comando | Descripción |
|--------|-------------|
| `terraform validate` | Valida la sintaxis de los archivos `.tf` |
| `terraform fmt` | Formatea los archivos al estilo estándar de Terraform |
| `terraform show` | Muestra el estado actual o un plan guardado |
| `terraform output` | Muestra los valores de los outputs definidos |
| `terraform graph` | Genera un grafo de dependencias en formato DOT |

### Estado (`state`)

| Comando | Descripción |
|--------|-------------|
| `terraform state list` | Lista todos los recursos en el estado |
| `terraform state show <recurso>` | Muestra los atributos de un recurso específico |
| `terraform state mv` | Mueve un recurso dentro del estado |
| `terraform state rm` | Elimina un recurso del estado (sin destruirlo) |
| `terraform state pull` | Descarga el estado remoto |
| `terraform state push` | Sube un estado local al backend remoto |
| `terraform state replace-provider` | Reemplaza el provider de recursos en el estado |

### Workspace

| Comando | Descripción |
|--------|-------------|
| `terraform workspace list` | Lista todos los workspaces |
| `terraform workspace new <nombre>` | Crea un nuevo workspace |
| `terraform workspace select <nombre>` | Cambia al workspace indicado |
| `terraform workspace show` | Muestra el workspace activo |
| `terraform workspace delete <nombre>` | Elimina un workspace |

### Importación y movimiento

| Comando | Descripción |
|--------|-------------|
| `terraform import <recurso> <id>` | Importa un recurso existente al estado |
| `terraform moved` | Bloque de configuración para renombrar recursos sin recrearlos |

### Providers y módulos

| Comando | Descripción |
|--------|-------------|
| `terraform providers` | Muestra los providers requeridos por la configuración |
| `terraform providers lock` | Actualiza el lock file de providers |
| `terraform providers mirror` | Copia providers a un directorio local |
| `terraform providers schema` | Muestra el schema de los providers |
| `terraform get` | Descarga e instala módulos |

### Testing y depuración

| Comando | Descripción |
|--------|-------------|
| `terraform test` | Ejecuta pruebas definidas en archivos `.tftest.hcl` |
| `terraform console` | Abre una consola interactiva para evaluar expresiones HCL |
| `terraform force-unlock <lock-id>` | Libera un lock de estado manualmente |
| `terraform taint` *(deprecado)* | Marca un recurso para ser recreado en el próximo apply |
| `terraform untaint` *(deprecado)* | Desmarca un recurso previamente taintado |

### Flags comunes útiles

```bash
terraform plan -out=plan.tfplan        # Guarda el plan en un archivo
terraform apply plan.tfplan            # Aplica un plan guardado
terraform apply -auto-approve          # Aplica sin pedir confirmación
terraform destroy -target=<recurso>    # Destruye solo un recurso específico
terraform plan -var="env=prod"         # Pasa una variable en línea
terraform plan -var-file="prod.tfvars" # Usa un archivo de variables
terraform init -upgrade                # Actualiza providers al inicializar
terraform fmt -recursive               # Formatea subdirectorios también
```

---

Puedes ver ayuda de cualquier comando con `terraform <comando> -help`, por ejemplo:

```bash
terraform apply -help
```