targetScope = 'subscription'

@description('The name of the project')
param projectName string

@description('The name of the environment')
param environmentName string

@description('The location for the resource group and storage account')
param location string

@description('The name of the resource group')
param resourceGroupName string = '${environmentName}-${projectName}-swecent'

// Storage Account

@description('The name of the storage account')
param landingStorageAccountName  string = '${environmentName}landing${projectName}'

@description('The name of the storage account')
param stagingStorageAccountName  string = '${environmentName}staging${projectName}'

@description('The SKU for the storage account (e.g., Standard_LRS, Standard_GRS)')
param storageAccountSku string

@description('The storage tier for the storage account (e.g., Hot, Cool)')
param storageTier string

@description('The name of the landing container to create')
param landingContainerName string

@description('The name of the landing container to create')
param stagingContainerName string


// Data Factory

@description('The name of the data factory')
param dataFactoryName string = '${environmentName}datafactory${projectName}'

// Key Vault
@description('The name of the key vault')
param keyVaultName string = '${environmentName}keyvault${projectName}'

// SQL Database

@description('The name of the Azure SQL Server.')
param sqlServerName string = '${environmentName}sqlserver${projectName}'

@description('The administrator username for the Azure SQL Server.')
param adminUsername string

@description('The administrator password for the Azure SQL Server.')
@secure()
param adminPassword string

@description('The name of the Azure SQL Database.')
param databaseName string

@description('The name of DataBricksworkspace workspace')
param workspaceName string = '${environmentName}databricks${projectName}'


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module landingStorageAccountModule 'modules/landingStorageAccount.bicep' = {
  name: 'landingStorageAccountDeployment'
  scope: resourceGroup
  params: {
    storageAccountName: landingStorageAccountName
    location: location
    storageAccountSku: storageAccountSku
    storageTier: storageTier
    landingContainerName: landingContainerName
  }
}

module stagingStorageAccountModule 'modules/landingStorageAccount.bicep' = {
  name: 'stagingstorageAccountDeployment'
  scope: resourceGroup
  params: {
    storageAccountName: stagingStorageAccountName
    location: location
    storageAccountSku: storageAccountSku
    storageTier: storageTier
    landingContainerName: stagingContainerName
  }
}

module datafactoryModule 'modules/dataFactory.bicep' = {
  name: 'dataFactoryDeployment'
  scope: resourceGroup
  params: {
    dataFactoryName: dataFactoryName
    location: location
  }
}


module keyVaultModule 'modules/keyVault.bicep' = {
  name: 'keyVaultDeployment'
  scope: resourceGroup
  params: {
    keyVaultName: keyVaultName
    location: location
  }
}

module sqlDatabaseModule 'modules/sqlDatabase.bicep' = {
  name: 'sqlDatabaseDeployment'
  scope: resourceGroup
  params: {
    sqlServerName: sqlServerName
    adminUsername: adminUsername
    adminPassword: adminPassword
    databaseName: databaseName
  }
}

module dataBricksModule 'modules/dataBricks.bicep' = {
  name: 'dataBricksDeployment'
  scope: resourceGroup
  params: {
    workspaceName: workspaceName
    location: location
  }
}
