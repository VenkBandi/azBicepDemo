@description('Storage Account type')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param storageAccountSku string

@description('The name of the storage account')
param storageAccountName string

@description('The location for the storage account')
param location string

@description('The storage tier for the storage account')
@allowed([
  'Hot'
  'Cool'
])
param storageTier string


resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties: {
    accessTier: storageTier
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    isHnsEnabled: true
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    encryption: {
      requireInfrastructureEncryption: true
      keySource: 'Microsoft.Storage'
      services: {
        blob: {
          enabled: true
        }
      }
    }
  }
}

// Blob Services - Settings
resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    lastAccessTimeTrackingPolicy: {
      blobType: [
        'string'
      ]
      enable: true
      name: 'AccessTimeTracking'
      trackingGranularityInDays: 1
    }
  }
}

@description('The name of the landing container to create')
param containerName1 string

resource containerCreation1 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: containerName1
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}

@description('The name of the landing container to create')
param containerName2 string

resource containerCreation2 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: containerName2
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}
output storageAccountId string = storageAccount.id  
output storageAccountName string = storageAccount.name

