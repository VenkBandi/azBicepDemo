
@description('The name of the Azure SQL Server.')
param sqlServerName string

@description('The administrator username for the Azure SQL Server.')
param adminUsername string

@description('The administrator password for the Azure SQL Server.')
@secure()
param adminPassword string

@description('The name of the Azure SQL Database.')
param databaseName string

@description('The pricing tier for the Azure SQL Database.')
param skuName string = 'Basic'

@description('The compute size of the Azure SQL Database.')
param skuTier string = 'Basic'

@description('The location for the resources.')
param location string = resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2022-02-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-02-01-preview' = {
  parent: sqlServer
  name: databaseName
  location: location
  properties: {
    createMode: 'Default'
    sampleName: 'AdventureWorksLT' // Specifies the AdventureWorksLT sample database
  }
  sku: {
    name: skuName
    tier: skuTier
  }
}

output sqlServerName string = sqlServer.name
output sqlDatabaseName string = sqlDatabase.name
