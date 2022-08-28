# BicepRepo
This repo uses following secrets for deploying and configuring resources on Azure using Github actions workflow

**AZURE_CREDENTIALS** - This is service principal json object for login to azure.

Run the following commands to obtain the required json

```
az ad sp create-for-rbac --name "myApp" --role contributor \
                            --scopes /subscriptions/{subscription-id} \
                            --sdk-auth
# Replace the subscription id with appropriate value                           
# The command should output a JSON object similar to this:
 
{
    "clientId": "<GUID>",
    "clientSecret": "<STRING>",
    "subscriptionId": "<GUID>",
    "tenantId": "<GUID>",
    "resourceManagerEndpointUrl": "<URL>"
    (...)
}
```
**AZ_ADP_SUB2_ID** - Subscription ID where resources will be deployed

**CLUSTER_ADMIN_GROUP_ID** - Azure AD group id to be set as K8s cluster and grafana administrator.
