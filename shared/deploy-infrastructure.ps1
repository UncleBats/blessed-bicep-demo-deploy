[CmdletBinding()]
param
(
  [Parameter(Mandatory=$true)]
  [string] $environmentCode, 

  [Parameter(Mandatory=$true)]
  [string] $resourceGroupPrefix,

  [Parameter(Mandatory=$true)]
  [string] $templateFile
)

function DeployEnvironment {
    [CmdletBinding()]
    param(
        [string] $environmentCode,
        [string] $resourceGroupPrefix,
        [string] $templateFile
    )

    $resourceGroup = "$resourceGroupPrefix-$environmentCode"

    az group create `
        --location westeurope `
        --resource-group $resourceGroup
    if ($LASTEXITCODE) {
      throw "Unable to create resourcegroup [$resourceGroup] in westeurope"
    }

    az deployment group create `
        --template-file $templateFile `
        --resource-group $resourceGroup `
        --parameters env="$environmentCode" `
        --output tsv
    if ($LASTEXITCODE) {
      throw "Unable to deploy bicep to resourcegroup [$resourceGroup]"
    }
}

DeployEnvironment -environmentCode $environmentCode -resourceGroupPrefix $resourceGroupPrefix -templateFile $templateFile