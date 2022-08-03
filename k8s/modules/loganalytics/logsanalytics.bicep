param location string
param logAnalyticsWorkspaceName string

resource loganalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: { 
     sku: {
       name: 'PerGB2018'
     }
  }
}
output logAnalyticsWorkspaceId string = loganalytics.id
