Import-Module ActiveDirectory

# Prompt for the username
$UserIdentity = Read-Host "Enter the sAMAccountName of the user"

# Retrieve the user with the required properties
$User = Get-ADUser -Identity $UserIdentity -Properties DistinguishedName, Enabled, LastLogonDate, whenChanged

# Display the user details
$User | Format-List DistinguishedName, Enabled, LastLogonDate, whenChanged
