param sshKeyData string
param clusterName string
param location string
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
