# Azure SQL Helloworld Project

This project is an Azure SQL Database project that includes a table called "Helloworld" and is set up for deployment using Bicep templates and Azure DevOps pipelines.

## Goal

Create an azure sql db that uses an Entra group to securely manage administrators and includes the Azure DevOps workload in the group to support deployments.

## Project Structure

- **helloworld/**: Contains the SQL project files.
  - **Helloworld.sqlproj**: The SQL project file that defines the project structure and build settings.
  - **Helloworld.sql**: SQL definition for the "Helloworld" table.

- **bicep/**: Contains Bicep templates for infrastructure deployment.
  - **main.bicep**: Bicep template for deploying the Azure SQL Database with Entra authentication.
  - **main.bicepparam**: Bicep parameters file for the main Bicep template - replace with your own values.

- **pipelines/**: Contains Azure DevOps pipeline definitions.
  - **azure-pipelines-bicep.yml**: Pipeline for linting, validating, and deploying Bicep files.
  - **release-pipeline-bicep.yml**: Release pipeline stage task for deploying the Bicep template to Azure - you will need to configure the rest of the release manually
  - **azure-pipelines-db.yml**: Pipeline for building and testing the DACPAC.
  - **release-pipeline-db.yml**: Release pipeline for deploying the DACPAC to Azure SQL Database  - you will need to configure the rest of the release manually



## Setup Instructions

1. **Clone the Repository**: Clone this repository to your local machine.
2. **Open the Project**: Open the project in your preferred code editor.
3. **Create Entra Group**: Create a group that you can use to make an admin user for the Azure SQL Database. This group will be used for Entra authentication.
4. **Configure Bicep Parameters**: Update the `bicep/main.bicepparam` file with your specific values, such as the database server name, database name, location, server administrator login, password, service principal display name, and service principal object ID.
5. **Set Up Azure DevOps**: Create a new Azure DevOps project and blank repository.
6. **Set upstream and push**: Set the upstream to your Azure DevOps repo and push the local changes.
7. **Create Service Connections**: In Azure DevOps, create service connection for your subscription using the workload identity option. https://learn.microsoft.com/en-gb/azure/devops/pipelines/library/connect-to-azure?view=azure-devops#create-an-azure-resource-manager-service-connection-using-workload-identity-federation
8. **Add service connection to group**: Add the service connection to the Entra group you created earlier. This will allow AzDO to manage the Azure SQL Database.
9. **Configure pipelines**: Use the Azure DevOps pipelines to build the bicep and validate the database.
10. **Configure release pipelines**: Set up the release pipelines to deploy the Bicep template and the DACPAC to the Azure SQL Database. You will need to configure the release pipeline manually in Azure DevOps.

## Usage

After deployment, there will be a secure deployment of you SQL Server and Database, with the Entra group managing the administrators. You can use add yourself to the admin group to login to the Azure SQL Database using Entra authentication.

## Additional Information

This project is configured to use Entra authentication for secure access to the Azure SQL Database. Ensure that you have the necessary permissions and configurations to operate in your Azure and Azure DevOps environments.