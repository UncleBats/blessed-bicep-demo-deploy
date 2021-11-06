targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param env string


param saName string = 'acrblessed${uniqueString(resourceGroup().id)}-${env}'

module sa './templates/storageaccount.bicep' = {
  name: 'blessed-sa-${env}'
  params:{
    name: saName
    containers: [
      'mycontainer'
    ]
  }
}
