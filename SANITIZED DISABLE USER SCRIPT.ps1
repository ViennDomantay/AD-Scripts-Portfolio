# 1. CREATION OF OU (EDIT $ParentOU, $NewOUName)

# Define the parent OU Distinguished Name (DN) (Placeholder used)
$ParentOU = "OU=For Deletion,OU=RPA,DC=yourcompany,DC=com,DC=xx"

# Define the name of the new OU to be created
$NewOUName = "yyyymmdd"

# Create the new Organizational Unit
New-ADOrganizationalUnit -Name $NewOUName -Path $ParentOU

# Confirm the creation
Write-Host "Organizational Unit $NewOUName has been created under $ParentOU."

# 2. DISABLING OF USER, MOVING USER TO DELETION OU (Edit $UserIdentity, $NewDescription, $TargetOU)

# Define the user to modify (replace with actual sAMAccountName or UserPrincipalName)
$UserIdentity = "YourUserAccount"

# Define the new description and target OU (Placeholder used)
$NewDescription = "Deactivation ticket WO"
$TargetOU = "OU=yyyymmdd,OU=For Deletion,OU=RPA,DC=yourcompany,DC=com,DC=xx"

# Disable the user account
Disable-ADAccount -Identity $UserIdentity

# Get the user's group memberships
$UserGroups = Get-ADUser -Identity $UserIdentity -Properties MemberOf | Select-Object -ExpandProperty MemberOf

# Remove the user from all groups
foreach ($Group in $UserGroups) {
    Remove-ADGroupMember -Identity $Group -Members $UserIdentity -Confirm:$false
}

# Set the msExchHideFromAddressLists attribute to True
Set-ADUser -Identity $UserIdentity -Replace @{msExchHideFromAddressLists=$true}

# Update the description
Set-ADUser -Identity $UserIdentity -Description $NewDescription

# Move the user to the target OU
Move-ADObject -Identity (Get-ADUser -Identity $UserIdentity).DistinguishedName -TargetPath $TargetOU

# Confirm the changes
Write-Host "User $UserIdentity has been disabled, removed from all groups, hidden from address lists, description updated, and moved to OU $TargetOU."
