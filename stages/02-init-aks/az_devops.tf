#resource "azuredevops_project" "this" {
#  name       = "SCA"
#  description        = "SCA Project"
#}
#
#resource "azuredevops_git_repository" "this" {
#  project_id = azuredevops_project.this.id
#  name       = "Hello World Repository"
#  initialization {
#    init_type = "Clean"
#  }
#}
#
#resource "azuredevops_variable_group" "this" {
#  project_id   = azuredevops_project.this.id
#  name         = "SCA Pipeline Variables"
#  description  = "Managed by Terraform"
#  allow_access = true
#
#  variable {
#    name  = "API_KEY"
#    value = "helloworld"
#  }
#}
#
#resource "azuredevops_serviceendpoint_azurerm" "acr_connection" {
#  project_id      = azuredevops_project.this.id
#  service_endpoint_name = "sca_acr"
#  credentials {
#    serviceprincipalid  = var.azdevops_service_principal_id
#    serviceprincipalkey =  var.azdevops_service_principal_key
#  }
#  azurerm_spn_tenantid      = var.azurerm_spn_tenantid
#  azurerm_subscription_id   = var.azurerm_subscription_id
#  azurerm_subscription_name = var.azurerm_subscription_name
#}
#
#resource "azuredevops_build_definition" "example" {
#  project_id = azuredevops_project.this.id
#  name       = "SCA Build Definition"
#
#  ci_trigger {
#    use_yaml = false
#  }
#
#  schedules {
#    branch_filter {
#      include = ["master"]
#      exclude = ["cicd", "staging"]
#    }
#    days_to_build              = ["Wed", "Sun"]
#    schedule_only_with_changes = true
#    start_hours                = 10
#    start_minutes              = 59
#    time_zone                  = "(UTC) Coordinated Universal Time"
#  }
#
#  repository {
#    repo_type   = "TfsGit"
#    repo_id     = azuredevops_git_repository.this.id
#    branch_name = azuredevops_git_repository.this.default_branch
#    yml_path    = "azure-pipelines.yml"
#  }
#
#  variable_groups = [
#    azuredevops_variable_group.this.id
#  ]
#
#  variable {
#    name  = "PipelineVariable"
#    value = "trigger"
#  }
#
#  variable {
#    name         = "PipelineSecret"
#    secret_value = "ZGV2cw"
#    is_secret    = true
#  }
#}