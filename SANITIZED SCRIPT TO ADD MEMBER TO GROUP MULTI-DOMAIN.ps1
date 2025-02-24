# Prompt for credentials
$cred = Get-Credential

# Define the target domain controller
$server = "hostname.yourcompany.com"

$SamAccountName = Read-Host "Enter SamAccountName"

# Add user to the group
Add-ADGroupMember -Server $server ` -Credential $cred ` -Identity "Group Name" -Members $SamAccountName