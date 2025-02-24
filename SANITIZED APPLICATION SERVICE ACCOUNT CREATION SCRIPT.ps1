# Import Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Prompt for user details
$FirstName = Read-Host "Enter First Name"
$LastName = Read-Host "Enter Last Name"
$FullName = Read-Host "Enter Full Name"
$SamAccountName = Read-Host "Enter SamAccountName"
$UPN = "$SamAccountName@yourcompany.com"  # Auto-generate UPN
$Email = Read-Host "Enter Email Address"
$Password = Read-Host "Enter Password" -AsSecureString

# Specify the Organizational Unit (Modify as needed)
$OU = "OU=Service and Admin Accounts,DC=yourcompany,DC=com,DC=xx"

# Create the new user
New-ADUser -GivenName $FirstName `
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

# Add user to password policy and restricted logon groups (Placeholders used)
Add-ADGroupMember -Identity "Your-Password-Policy-Group" -Members $SamAccountName
Add-ADGroupMember -Identity "Your-Deny-Logon-Group" -Members $SamAccountName

# Set a custom service account attribute (Placeholder used)
Set-ADUser -Identity $SamAccountName -Replace @{customServiceAccountAttribute="1"}

Write-Host "User $FullName ($SamAccountName) created successfully with email: $Email and UPN: $UPN"
