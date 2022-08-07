param sshKeyData string
param clusterName string
param logAnalyticsWorkspaceID string
param location string
param clusterAdminGroupId string
resource aksDemo 'Microsoft.ContainerService/managedClusters@2022-05-02-preview' = {
  name: clusterName
  location: location
  sku: {
    name: 'Basic'
    tier:'Free'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties:{
  aadProfile:{
    adminGroupObjectIDs: [clusterAdminGroupId]
    enableAzureRBAC: true
    managed: true
  }  
  agentPoolProfiles: [
    {
      name: 'agentpool1'
      count: 1
      vmSize: 'Standard_D2_v2'
      osType: 'Linux'
      enableAutoScaling:true
      maxCount: 2
      minCount: 1
      mode:'System'
    }
   ]
   networkProfile:{
    networkPlugin:'azure'
   }
   addonProfiles: {
    httpApplicationRouting: {
      enabled: true
    }
    omsagent: {
        enabled: true
        config: {
          logAnalyticsWorkspaceResourceID: logAnalyticsWorkspaceID
        }
      }
   }
   linuxProfile:{
    adminUsername:'adminuser'
    ssh:{
      publicKeys: [
        {
          keyData: sshKeyData
        }
      ]
    }
   }
   dnsPrefix: 'adp-aks-demo'
  }
}

output ClusterDNS string = aksDemo.properties.addonProfiles.httpApplicationRouting.config.HTTPApplicationRoutingZoneName
