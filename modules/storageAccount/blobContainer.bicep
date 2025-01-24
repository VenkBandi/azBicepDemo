@description('The name of the container to create.')
param containerName string

@description('The resource ID of the existing storage account.')
param storageAccountId string

resource storageContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: '${storageAccountId}/blobServices/default'
  name: containerName
  properties: {}
}
