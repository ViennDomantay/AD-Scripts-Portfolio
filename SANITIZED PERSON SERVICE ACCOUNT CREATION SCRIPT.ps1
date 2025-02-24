# Import Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Define the target domain controller
$server = "hostname.company.com"

# Prompt for user details
$FirstName = Read-Host "Enter First Name"
$LastName = Read-Host "Enter Last Name"
$FullName = Read-Host "Enter Full Name"
$SamAccountName = Read-Host "Enter SamAccountName"
$UPN = "$SamAccountName@company.com"  # Auto-generate UPN
$Email = Read-Host "Enter Email Address"
$Password = Read-Host "Enter Password" -AsSecureString

# Specify the Organizational Unit (Modify as needed)
$OU = "OU=Service and Admin Accounts,DC=company,DC=com"

# Create the new user
New-ADUser -Server $server `
	   -GivenName $FirstName `
           -Surname $LastName `
           -SamAccountName $SamAccountName `
           -UserPrincipalName $UPN `
           -Name $FullName `
           -DisplayName $FullName `
           -Path $OU `
           -EmailAddress $Email `
           -AccountPassword $Password `
           -Enabled $true `
           -ChangePasswordAtLogon $false `
           -PassThru

# Add user to the group
Add-ADGroupMember -Identity "Group" -Members $SamAccountName

# Set the custom attribute to 1
Set-ADUser -Identity $SamAccountName -Replace @{customAttribute="1"}

Write-Host "User $FullName ($SamAccountName) created successfully with email: $Email and UPN: $UPN on $server"


