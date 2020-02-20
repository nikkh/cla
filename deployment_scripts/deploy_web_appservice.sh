#!/bin/bash
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo   Deploy App Service for Web Application
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo ---B2C config environment variables
echo "B2C_INSTANCE: $B2C_INSTANCE"
echo "B2C_DOMAIN: $B2C_DOMAIN"
echo "B2C_SIGNEDOUT_CALLBACK_PATH: $B2C_SIGNEDOUT_CALLBACK_PATH"
echo "B2C_SIGNUPSIGNIN_POLICYID: $B2C_SIGNUPSIGNIN_POLICYID"
echo "B2C_RESETPASSWORD_POLICYID: B2C_RESETPASSWORD_POLICYID"
echo "B2C_EDITPROFILE_POLICYID: $B2C_EDITPROFILE_POLICYID"
echo "B2C_CALLBACK_PATH: $B2C_EDITPROFILE_POLICYID"

echo ---B2C config secrets (all masked)
echo "B2C_WEB_CLIENTID: $B2C_WEB_CLIENTID"
echo "B2C_API_CLIENTID: $B2C_API_CLIENTID"
echo "B2C_WEB_CLIENTSECRET: $B2C_WEB_CLIENTSECRET"

echo ---todo service config
echo "TODO_SCOPE: $TODO_SCOPE"
echo "TODO_BASEADDRESS: $TODO_BASEADDRESS"

echo ---Application config
echo "APPLICATION_NAME_ROOT: $APPLICATION_NAME_ROOT"
echo "LOCATION: $LOCATION"

# Derive as many variables as possible
webAppName="${APPLICATION_NAME_ROOT}-web"
apiAppName="${APPLICATION_NAME_ROOT}-api"
hostingPlanName="${APPLICATION_NAME_ROOT}-plan"
resourceGroupName="${APPLICATION_NAME_ROOT}-rg"
apiBaseAddress="${apiAppName}-api.azurewebsites.net"

echo ---derived variables
echo "Resource Group Name: $resourceGroupName"
echo "Hosting Plan: $hostingPlanName"
echo "Web App Name: $webAppName"
echo "Api App Name: $apiAppName"
echo "Api Base address: $apiBaseAddress"

echo --- create resource group
az group create --location $LOCATION --name $resourceGroupName
