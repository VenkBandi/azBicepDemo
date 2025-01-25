targetScope = 'subscription'

@description('The name of the project')
param projectName string

@description('The name of the environment')
param environmentName string

@description('The location for the resource group and storage account')
param location string

@description('The name of the resource group')
param resourceGroupName string = '${environmentName}-${projectName}-swecent'

@description('The name of the storage account')
param storageAccountName  string = '${environmentName}strageaccnt${projectName}'

@description('The SKU for the storage account (e.g., Standard_LRS, Standard_GRS)')
param storageAccountSku string

@description('The storage tier for the storage account (e.g., Hot, Cool)')
param storageTier string

@description('The name of the container to create')
param containerName string

@description('The name of the data factory')
param dataFactoryName string = '${environmentName}datafactory${projectName}'

@description('The name of the key vault')
param keyVaultName string = '${environmentName}keyvault${projectName}'

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
