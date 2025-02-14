@description('Specifies whether to deploy Azure Databricks workspace with Secure Cluster Connectivity (No Public IP) enabled or not')
param disablePublicIp bool = true

@description('The name of the Azure Databricks workspace to create.')
param workspaceName string


@description('The pricing tier of workspace.')
@allowed([
  'standard'
  'premium'
])
param pricingTier string = 'standard'

@description('Location for all resources.')
param location string = resourceGroup().location

var managedResourceGroupName = 'databricks-rg-${workspaceName}-${uniqueString(workspaceName, resourceGroup().id)}'
var trimmedMRGName = substring(managedResourceGroupName, 0, min(length(managedResourceGroupName), 90))
var managedResourceGroupId = '${subscription().id}/resourceGroups/${trimmedMRGName}'

resource workspace  'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: workspaceName
  location: location
  properties: {
    managedResourceGroupId: managedResourceGroupId
    parameters: {
      enableNoPublicIp: {
        value: disablePublicIp
      }
  }
  }
  sku: {
    name: 'Premium'
    tier: pricingTier
}
}
