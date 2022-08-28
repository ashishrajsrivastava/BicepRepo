param grafanaInstanceName string = 'adp-grafana-demo-01'
param grafanaInstanceLocation string = 'eastus'
param grafanaAdminObjectId string

targetScope = 'subscription'

resource demoRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${grafanaInstanceName}-rg'
  location: grafanaInstanceLocation
}
module deployGrafana 'modules/grafana/grafana.bicep' = {
  name: grafanaInstanceName
  scope: demoRG
  params: {
    grafanaLocation: grafanaInstanceLocation
    grafanaResourceName: grafanaInstanceName
    grafanaAdminGroupObjectId: grafanaAdminObjectId
  }
}

resource grafanaReaderRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(demoRG.id,subscription().id)
  scope: subscription()
  properties: {
    description: '${grafanaInstanceName} Monitoring Reader Role Assignment'
    principalId: deployGrafana.outputs.grafanaInstanceManagedIdentity
    principalType: 'ServicePrincipal'
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '43d0d8ad-25c7-4714-9337-8ba259a9fe05')
  }
}
