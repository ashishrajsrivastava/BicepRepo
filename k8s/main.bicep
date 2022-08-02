param clusterName string
param clusterLocation string
param clusterAdminGroupId string


targetScope = 'subscription'

resource demoRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${clusterName}-rg'
  location: clusterLocation
}

module logAnalyticsWorkspace 'modules/loganalytics/logsanalytics.bicep' = {
  scope: demoRG
  name: '${clusterName}-workspace'
  params: {
    location: clusterLocation
    logAnalyticsWorkspaceName: '${clusterName}-workspace' 
  }
}
module aksDemo 'modules/aks/aks.bicep' = {
  name: 'aks-demo'
  scope: demoRG
  params:{
    clusterName: clusterName
    location: clusterLocation
    clusterAdminGroupId: clusterAdminGroupId
    logAnalyticsWorkspaceID: logAnalyticsWorkspace.outputs.logAnalyticsWorkspaceId
    sshKeyData:'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTcbzshJxj5fHxZwyIGW9fIAjJjB+Lft7bNXq9JW9eIWnm8CwXJDK/5tiPZ5icRJgflCQneXI3mQqkwEwJKbYqdvy9qXH/S5uHFmp4Q471OD1aryYUQEhHR+v4JLohjQ4cv22VLBlNYAfji/JvY/uHLxnuYhpNKLK7T6j5lHXDquXT+JYaf+DcSNe/y/G49SIrrNspWk1No4tfccCQtYiCEq6Rt+3MTARXIgiKlf0SVhQ/3OC1z9o7zXwz59DhUubeDeZ9jwZJI+/1OvojxDMfgZpBaoVVMEzMxLpCUlQYTfDeiXfvMH+XePOLPgWZLFWwkXQhvjtZO6J5m8ksR0JdLB55629Wn0nrgASQeG44KN+cABwaj/fWAJtKwtZJt3lyt5MmcVTcTx8q27aXERJmSEJfgNVW6iUcE1VcQlTUk1nvb70+yarBiQ7KtVx4E68verk4J2c9SEpfWVYbkFQLBwCi3HldkpZllXi3VnozH1d6qQjov3rxAhdQ0ev3ccM= ashis@LAPTOP-GPO2IH7S'
  }
}
