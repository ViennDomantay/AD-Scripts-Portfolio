# Import Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Prompt for user details
$SamAccountName = Read-Host "Enter SamAccountName"
$ProxyAddress1 = Read-Host "Enter First Proxy Address (e.g., SMTP:user@yourcompany.com)"
$ProxyAddress2 = Read-Host "Enter Second Proxy Address (e.g., smtp:user@yourcompany.mail.onmicrosoft.com)"
$TargetAddress = Read-Host "Enter Target Address (e.g., SMTP:user@yourcompany.mail.onmicrosoft.com)"

# Convert proxy addresses into a string array
$ProxyAddressesArray = [string[]]@($ProxyAddress1, $ProxyAddress2)

# Update the user with proxyAddresses and targetAddress
Set-ADUser -Identity $SamAccountName -Replace @{
    proxyAddresses = $ProxyAddressesArray
    targetAddress = $TargetAddress
}

Write-Host "Proxy Addresses and Target Address added successfully for user: $SamAccountName"
