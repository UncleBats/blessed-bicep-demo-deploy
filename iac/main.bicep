targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param env string


param saName string = 'acrblessed${uniqueString(resourceGroup().id)}'

module sa 'br:bicepsharedregistry.azurecr.io/bicep/modules/storage:0.5.0' = {
  name: 'blessed-sa'
  params:{
    name: saName
    containers: [
      'mycontainer'
    ]
  }
}
