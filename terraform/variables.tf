variable "app_service_name" {
  description = "The name of the Azure App Service"
  type        = string
  default     = "myAppService"
}

variable "app_service_plan_name" {
  description = "The name of the App Service plan"
  type        = string
  default     = "myAppServicePlan"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "myResourceGroup"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "polandcentral"
}

variable "database_name" {
  description = "The name of the MySQL or PostgreSQL database"
  type        = string
  default     = "mydbserver"
}

variable "unique_suffix" {
  description = "A unique suffix to append to resource names to avoid conflicts"
  type        = string
  default     = "jti"
}

variable "database_username" {
  description = "The username for the database"
  type        = string
  default     = "dbadmin"
}

variable "database_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
  default     = "Jti12345"
}

variable "private_endpoint_name" {
  description = "The name of the private endpoint for the database"
  type        = string
  default     = "myPrivateEndpoint"
}

variable "environment" {
  description = "The environment to deploy (e.g., dev, staging, production)"
  type        = string
  default     = "dev"
}
