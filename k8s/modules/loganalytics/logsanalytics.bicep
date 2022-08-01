param location string
param logAnalyticsWorkspaceName string

resource loganalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: { 
     sku: {
       name: 'Free'
     }
  }
}
output logAnalyticsWorkspaceId string = loganalytics.id
