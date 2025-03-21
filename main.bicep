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
param storageAccountName  string = '${environmentName}strageaccnt${projectName}'

@description('The SKU for the storage account (e.g., Standard_LRS, Standard_GRS)')
param storageAccountSku string

@description('The storage tier for the storage account (e.g., Hot, Cool)')
param storageTier string

@description('The name of the container to create')
param containerName string

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


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module storageAccountModule 'modules/storageAccount.bicep' = {
  name: 'storageAccountDeployment'
  scope: resourceGroup
  params: {
    storageAccountName: storageAccountName
    location: location
    storageAccountSku: storageAccountSku
    storageTier: storageTier
    containerName: containerName
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
