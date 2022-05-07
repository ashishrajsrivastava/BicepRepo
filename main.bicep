resource MyStorageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: 'adpstorage05'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
