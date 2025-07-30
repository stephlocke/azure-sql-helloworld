@description('DB Server: Display name of resource')
param dbServerName string

@description('DB Server: Name of SQL Database')
param databaseName string

@description('DB Server: Location of resource')
param location string = resourceGroup().location

@secure()
@description('DB Server: Name of admin')
param dbServerAdministratorLogin string

@secure()
@description('DB Server: SQL Database password')
param dbServerPassword string

@secure()
@description('DB Server: Service Principal Object Id')
param servicePrincipalObjectId string

@secure()
@description('DB Server: Service Principal Display Name')
param servicePrincipalDisplayName string

@description('Tenant Id for the Azure Active Directory')
param tenantId string = 'be86044b-d319-460d-98fc-524004bd7133'


resource dbServer 'Microsoft.Sql/servers@2024-05-01-preview' = {
  name: dbServerName
  location: location
  properties: {
    administratorLogin: dbServerAdministratorLogin
    administratorLoginPassword: dbServerPassword
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    administrators: {
        administratorType: 'ActiveDirectory'
        principalType: 'Application'
        login: servicePrincipalDisplayName
        sid: servicePrincipalObjectId
        tenantId: tenantId
        azureADOnlyAuthentication: true
      }
    restrictOutboundNetworkAccess: 'Disabled'
  }
}


resource sqlDatabase 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: databaseName
  parent: dbServer
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource sqlFirewallRule 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  name: 'AllowAllAzureIPs'
  parent: dbServer
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
}


output sqlServerName string = dbServer.name
output sqlDatabaseName string = sqlDatabase.name
