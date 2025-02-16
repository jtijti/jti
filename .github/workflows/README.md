# CI/CD Pipeline

This CI/CD pipeline automates the following tasks:
- Build and push the Docker image to a container registry (Docker Hub).
- Deploy the Terraform infrastructure.
- Deploy the application to Azure App Service.
- Run some simple tests to verify the application.

## Setup Instructions

1. **Create GitHub Secrets:**

   Go to your GitHub repository settings and add the following secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username.
   - `DOCKER_PASSWORD`: Your Docker Hub password.
   - `CLIENT_ID`: Azure Service Principal client ID.
   - `CLIENT_SECRET`: Azure Service Principal client secret.
   - `SUBSCRIPTION_ID`: Azure subscription ID.
   - `TENANT_ID`: Azure tenant ID.
   - `AZURE_CREDENTIALS`: Azure credentials in JSON format.

2. **Modify the Workflow File:**

   The workflow file is located at `.github/workflows/ci-cd-pipeline.yml`. Make sure to:
   - Change the branch name in the `on` section to your branch name.
   - Update the Docker image name and tag in the `build-and-push-docker` and `deploy-app-service` jobs.

3. **Terraform Configuration:**

   Ensure your Terraform configuration files are in the repository and properly set up to deploy the required infrastructure.

4. **Run the Pipeline:**

   Push changes to the specified branch to trigger the pipeline. The pipeline will automatically execute the defined jobs.

## Example Test Command

The `run-tests` job includes a placeholder for running tests. You can replace the example test command with your own test commands.

```sh
curl -f https://my-app-service.azurewebsites.net || exit 1
```

This command checks if the application is accessible and returns a successful response.