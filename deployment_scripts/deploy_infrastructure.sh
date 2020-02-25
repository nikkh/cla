#!/bin/bash
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo   Create CLA Infrastructure
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ---B2C config environment variables
echo "B2C_INSTANCE: $B2C_INSTANCE"
echo "B2C_DOMAIN: $B2C_DOMAIN"
echo "B2C_SIGNEDOUT_CALLBACK_PATH: $B2C_SIGNEDOUT_CALLBACK_PATH"
echo "B2C_SIGNUPSIGNIN_POLICYID: $B2C_SIGNUPSIGNIN_POLICYID"
echo "B2C_RESETPASSWORD_POLICYID: B2C_RESETPASSWORD_POLICYID"
echo "B2C_EDITPROFILE_POLICYID: $B2C_EDITPROFILE_POLICYID"
echo "B2C_CALLBACK_PATH: $B2C_CALLBACK_PATH"

echo "---B2C config secrets (all masked)"
echo "B2C_WEB_CLIENTID: $B2C_WEB_CLIENTID"
echo "B2C_API_CLIENTID: $B2C_API_CLIENTID"
echo "B2C_WEB_CLIENTSECRET: $B2C_WEB_CLIENTSECRET"

echo ---Application config
echo "APPLICATION_NAME_ROOT: $APPLICATION_NAME_ROOT"
echo "LOCATION: $LOCATION"
echo "TODO_SCOPE: $TODO_SCOPE"

# Derive as many variables as possible
webAppName="${APPLICATION_NAME_ROOT}-web"
apiAppName="${APPLICATION_NAME_ROOT}-api"
hostingPlanName="${APPLICATION_NAME_ROOT}-plan"
resourceGroupName="${APPLICATION_NAME_ROOT}-rg"
apiBaseAddress="https://${apiAppName}.azurewebsites.net"

echo ---derived variables
echo "Resource Group Name: $resourceGroupName"
echo "Hosting Plan: $hostingPlanName"
echo "Web App Name: $webAppName"
echo "Api App Name: $apiAppName"
echo "Api Base address: $apiBaseAddress"

# set local variables
appServicePlanSku="S1"

echo --- common portion of app settings
commonSettings="AZUREADB2C_INSTANCE=$B2C__INSTANCE"
commonSettings="${commonSettings} AZUREADB2C__DOMAIN=$B2C_DOMAIN"
commonSettings="${commonSettings} AZUREADB2C__SIGNEDOUTCALLBACKPATH=$B2C_SIGNEDOUT_CALLBACK_PATH"
commonSettings="${commonSettings} AZUREADB2C__SIGNUPSIGNINPOLICYID=$B2C_SIGNUPSIGNIN_POLICYID"
commonSettings="${commonSettings} AZUREADB2C__RESETPASSWORDPOLICYID=$B2C_RESETPASSWORD_POLICYID"
commonSettings="${commonSettings} AZUREADB2C__EDITPROFILEPOLICYID=$B2C_EDITPROFILE_POLICYID"
commonSettings="${commonSettings} ASPNETCORE_ENVIRONMENT=Development"
echo "commonSettings=${commonSettings}"

echo --- "generate app settings for $webAppName"
webAppSettings="${commonSettings} AZUREADB2C__CLIENTID=$B2C_WEB_CLIENTID"
webAppSettings="${webAppSettings} AZUREADB2C__CLIENTSECRET=$B2C_WEB_CLIENTSECRET"
webAppSettings="${webAppSettings} AZUREADB2C__CALLBACKPATH=$B2C_CALLBACK_PATH"
webAppSettings="${webAppSettings} TODOLIST__TODOLISTSCOPE=$TODO_SCOPE"
webAppSettings="${webAppSettings} TODOLIST__TODOLISTBASEADDRESS=$apiBaseAddress"
echo "webAppSettings=${webAppSettings}"

echo --- "generate app settings for $apiAppName"
apiAppSettings="${commonSettings} AZUREADB2C__CLIENTID=$B2C_API_CLIENTID"
echo "apiAppSettings=${apiAppSettings}"

echo --- create resource group
az group create --location $LOCATION --name $resourceGroupName

echo --- create an app service plan in FREE tier
az appservice plan create --name $hostingPlanName --resource-group $resourceGroupName --sku $appServicePlanSku

echo --- create an app service to host the web app and update settings
az webapp create --name $webAppName --resource-group $resourceGroupName --plan $hostingPlanName
az webapp config appsettings set -g $resourceGroupName -n $webAppName --settings $webAppSettings

echo --- create an app service to host the api app and update settings
az webapp create --name $apiAppName --resource-group $resourceGroupName --plan $hostingPlanName
az webapp config appsettings set -g $resourceGroupName -n $apiAppName --settings $apiAppSettings

RED='\033[0;31m'
NC='\033[0m' # No Color
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo   Important Note!
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "This script ran with the APPLICATION_NAME_ROOT environment variable set to $APPLICATION_NAME_ROOT."
echo -e "${RED}PLEASE${NC} ensure that the yaml workflows for deploying your application use the same variable setting!"
