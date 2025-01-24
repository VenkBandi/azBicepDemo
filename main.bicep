targetScope = 'subscription'

@description('The name of the resource group to create')
param resourceGroupName string

@description('The location for the resource group and storage account')
param location string

@description('The name of the storage account')
param storageAccountName string

@description('The SKU for the storage account (e.g., Standard_LRS, Standard_GRS)')
param storageAccountSku string

@description('The storage tier for the storage account (e.g., Hot, Cool)')
param storageTier string

@description('The name of the container to create')
param containerName string

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
