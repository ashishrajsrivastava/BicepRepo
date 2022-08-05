param grafanaInstanceName string = 'adp-grafana-demo-01'
param grafanaInstanceLocation string = 'eastus'

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
  }
}
