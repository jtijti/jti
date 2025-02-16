# Initialize Terraform
terraform init

# Select or create a workspace for the environment
terraform workspace select XXX || terraform workspace new XXX

# Apply the configuration using the environment-specific variables
terraform apply -var-file="XXX.tfvars"
