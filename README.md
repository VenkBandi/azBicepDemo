Here's a draft of the `README.md` file based on your Bicep file:

---

# **Azure Infrastructure Deployment with Bicep**

This project deploys a set of Azure resources for a specific environment and project using Bicep. The resources include a Resource Group, a Storage Account, a Data Factory, and a Key Vault. This README provides an overview of the deployment process and the structure of the Bicep file.

---

## **Deployment Overview**

This Bicep file creates and configures the following Azure resources:
1. **Resource Group**: Organizes the resources.
2. **Storage Account**: Stores data with a specified SKU and tier.
3. **Data Factory**: Facilitates data orchestration and transformation.
4. **Key Vault**: Securely stores secrets and sensitive information.

The deployment uses three separate Bicep modules:
- **`storageAccount.bicep`**: Manages the Storage Account.
- **`dataFactory.bicep`**: Manages the Data Factory.
- **`keyVault.bicep`**: Manages the Key Vault.

---

## **Parameters**

The Bicep file uses the following parameters:

| **Parameter**          | **Description**                                                   | **Default Value**                                   | **Example Value**             |
|-------------------------|-------------------------------------------------------------------|---------------------------------------------------|--------------------------------|
| `projectName`           | The name of the project.                                         | _Required_                                        | `myproject`                   |
| `environmentName`       | The name of the environment (e.g., dev, prod).                  | _Required_                                        | `dev`                         |
| `location`              | The location for the resources.                                 | _Required_                                        | `East US`                     |
| `resourceGroupName`     | The name of the Resource Group.                                 | `${environmentName}-${projectName}-swecent`       | `dev-myproject-swecent`       |
| `storageAccountName`    | The name of the Storage Account.                                | `${environmentName}strageaccnt${projectName}`     | `devstrageaccntmyproject`     |
| `storageAccountSku`     | The SKU for the Storage Account (e.g., `Standard_LRS`).         | _Required_                                        | `Standard_LRS`                |
| `storageTier`           | The storage tier for the Storage Account (e.g., Hot, Cool).     | _Required_                                        | `Hot`                         |
| `containerName`         | The name of the container to create in the Storage Account.     | _Required_                                        | `mycontainer`                 |
| `dataFactoryName`       | The name of the Data Factory.                                   | `${environmentName}datafactory${projectName}`     | `devdatafactorymyproject`     |
| `keyVaultName`          | The name of the Key Vault.                                      | `${environmentName}keyvault${projectName}`        | `devkeyvaultmyproject`        |

---

## **Modules**

### 1. **Resource Group**
The Resource Group is created at the subscription level using the following Bicep resource:
```bicep
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01'
```

### 2. **Storage Account**
The `storageAccount.bicep` module manages the deployment of a Storage Account. It accepts parameters such as:
- `storageAccountName`
- `location`
- `storageAccountSku`
- `storageTier`
- `containerName`

### 3. **Data Factory**
The `dataFactory.bicep` module deploys a Data Factory instance in the Resource Group. It accepts:
- `dataFactoryName`
- `location`

### 4. **Key Vault**
The `keyVault.bicep` module deploys a Key Vault with the given name and location. It accepts:
- `keyVaultName`
- `location`

---

## **Usage Instructions**

### **Prerequisites**
1. **Azure CLI**: Install the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) to manage the deployment.
2. **Bicep CLI**: Ensure you have the [Bicep CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install) installed.
3. **Azure Subscription**: You need an active Azure Subscription with the appropriate permissions.

### **Deploy the Bicep File**
1. Log in to your Azure account:
   ```bash
   az login
   ```
2. Set your Azure subscription:
   ```bash
   az account set --subscription <Your-Subscription-ID>
   ```
3. Deploy the Bicep file:
   ```bash
   az deployment sub create \
     --name <Deployment-Name> \
     --location <Deployment-Location> \
     --template-file main.bicep \
     --parameters <parameterfile>.json
   ```

---

## **Example Deployment**

To deploy this Bicep file for a project named `myproject` in the `dev` environment in `East US`:
```bash
az deployment sub create \
  --name myproject-dev-deployment \
  --location eastus \
  --template-file main.bicep \
  --parameters dev
```

---

## **Outputs**
- **Resource Group**: A new resource group named `<environmentName>-<projectName>-swecent`.
- **Storage Account**: A storage account named `<environmentName>strageaccnt<projectName>`.
- **Data Factory**: A Data Factory named `<environmentName>datafactory<projectName>`.
- **Key Vault**: A Key Vault named `<environmentName>keyvault<projectName>`.

---

Feel free to customize this deployment for your project needs! Let me know if you encounter any issues.
