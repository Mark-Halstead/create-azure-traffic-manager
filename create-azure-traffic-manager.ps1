# Input parameters
$resourceGroupName = Read-Host "Enter the resource group name"
$trafficManagerName = Read-Host "Enter the Traffic Manager profile name"
$location = Read-Host "Enter the location (e.g., 'East US')"
$trafficRoutingMethod = Read-Host "Enter the traffic routing method (Performance, Priority, or Weighted)"
$endpointType1 = Read-Host "Enter the first endpoint type (AzureEndpoints, ExternalEndpoints, or NestedEndpoints)"
$endpointName1 = Read-Host "Enter the first endpoint name"
$endpointTarget1 = Read-Host "Enter the first endpoint target (e.g., URL or IP address)"
$endpointType2 = Read-Host "Enter the second endpoint type"
$endpointName2 = Read-Host "Enter the second endpoint name"
$endpointTarget2 = Read-Host "Enter the second endpoint target"

# Login to Azure (if not already logged in)
Connect-AzAccount

# Create the resource group if it doesn't exist
if (-not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}

# Create the Traffic Manager profile
$trafficManagerProfile = New-AzTrafficManagerProfile `
    -ResourceGroupName $resourceGroupName `
    -Name $trafficManagerName `
    -ProfileStatus Enabled `
    -TrafficRoutingMethod $trafficRoutingMethod `
    -RelativeDnsName $trafficManagerName `
    -Ttl 30 `
    -Location $location

Write-Host "Traffic Manager profile '$trafficManagerName' created successfully."

# Add the first endpoint
$endpoint1 = New-AzTrafficManagerEndpoint `
    -Name $endpointName1 `
    -ProfileName $trafficManagerName `
    -ResourceGroupName $resourceGroupName `
    -Type $endpointType1 `
    -Target $endpointTarget1 `
    -EndpointStatus Enabled

Write-Host "Endpoint '$endpointName1' added to Traffic Manager profile '$trafficManagerName'."

# Add the second endpoint
$endpoint2 = New-AzTrafficManagerEndpoint `
    -Name $endpointName2 `
    -ProfileName $trafficManagerName `
    -ResourceGroupName $resourceGroupName `
    -Type $endpointType2 `
    -Target $endpointTarget2 `
    -EndpointStatus Enabled

Write-Host "Endpoint '$endpointName2' added to Traffic Manager profile '$trafficManagerName'."

Write-Host "Traffic Manager configuration completed successfully."
