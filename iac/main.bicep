targetScope = 'resourceGroup'

param saName string = 'acrblessed${uniqueString(resourceGroup().id)}'

module sa './templates/storageaccount.bicep' = {
  name: 'blessed-sa'
  params:{
    name: saName
    containers: [
      'mycontainer'
    ]
  }
}
