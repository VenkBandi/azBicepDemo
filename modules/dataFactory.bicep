@description('The name of the data factory')
param dataFactoryName string

@description('The location for the resource group and storage account')
param location string

resource createDataFacory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
}

output dataFactoryResourceId string = createDataFacory.id

