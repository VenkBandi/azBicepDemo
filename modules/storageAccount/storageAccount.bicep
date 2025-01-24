
@description('The name of the storage account to create')
param storageAccountName string

@description('The location for the storage account')
param location string

@description('The SKU for the storage account (e.g., Standard_LRS, Standard_GRS)')
param storageAccountSku string

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Cool'
  }
}

output storageAccountId string = storageAccount.id  
output storageAccountName string = storageAccount.name

