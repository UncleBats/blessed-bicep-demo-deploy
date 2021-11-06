param name string

@description('Array of Blob containers to create - string')
param containers array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: name
  location: resourceGroup().location
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {}
}
 
resource blobservices 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  name: 'default'
  parent: storageAccount
}

//create containers if specified
resource storageAccountContainers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [for container in containers : if(!empty(containers)) {
  name: !empty(containers)? '${name}/default/${container}' : 'sk/ip/ped'
  dependsOn: [
    storageAccount
  ]
}]

output blobserviceId string = blobservices.id
