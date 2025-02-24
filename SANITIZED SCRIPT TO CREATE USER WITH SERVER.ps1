# Import Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Prompt for credentials
$cred = Get-Credential

# Define the target domain controller (Placeholder used)
$server = "your-dc.yourcompany.com"

# Prompt for user details
$FirstName = Read-Host "Enter First Name"
$LastName = Read-Host "Enter Last Name"
$FullName = Read-Host "Enter Full Name"
$SamAccountName = Read-Host "Enter SamAccountName"
$UPN = "$SamAccountName@yourcompany.com"  # Auto-generate UPN
$Email = Read-Host "Enter Email Address"
$Password = Read-Host "Enter Password" -AsSecureString

# Specify the Organizational Unit (Placeholder used)
$OU = "OU=All Users,DC=yourcompany,DC=com"

# Create the new user
New-ADUser -Server $server `
           -Credential $cred `
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

# Add user to the MFA-enabled group (Placeholder used)
Add-ADGroupMember -Server $server `
                  -Credential $cred `
                  -Identity "Your-MFA-Enabled-Group" `
                  -Members $SamAccountName

Write-Host "User $FullName ($SamAccountName) created successfully with email: $Email and UPN: $UPN on $server"

# Retrieve domain controller information (Placeholder used)
Get-ADDomainController -Server "your-dc.yourcompany.com"
