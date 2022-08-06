param grafanaResourceName string
param grafanaLocation string



resource centralGrafana 'Microsoft.Dashboard/grafana@2022-08-01' = {
  name: grafanaResourceName
   location: grafanaLocation
   properties:{
    autoGeneratedDomainNameLabelScope: 'TenantReuse'
    publicNetworkAccess:'Enabled'
    apiKey: 'Disabled'
    deterministicOutboundIP: 'Disabled'
    zoneRedundancy: 'Disabled'
   }
   sku: {
     name: 'Standard'
   }
   identity: {
     type: 'SystemAssigned'
   }
}


output grafanaInstanceManagedIdentity string = centralGrafana.identity.principalId 
