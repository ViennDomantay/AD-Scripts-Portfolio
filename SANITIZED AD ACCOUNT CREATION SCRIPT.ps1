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
$Department = Read-Host "Enter Department"
$JobTitle = Read-Host "Enter Job Title"
$ProxyAddress1 = Read-Host "Enter First Proxy Address (e.g., SMTP:user@yourcompany.com)"
$ProxyAddress2 = Read-Host "Enter Second Proxy Address (e.g., smtp:user@yourotherdomain.com)"
$ProxyAddress3 = Read-Host "Enter Third Proxy Address (e.g., smtp:user@yourcompany.mail.onmicrosoft.com)"
$TargetAddress = Read-Host "Enter Target Address (e.g., SMTP:user@yourcompany.mail.onmicrosoft.com)"
$EmployeeID = Read-Host "Enter Employee ID"

# Specify the Organizational Unit (Modify as needed)
$OU = "OU=All Users,DC=yourcompany,DC=com,DC=xx"

# Create the new user
New-ADUser -GivenName $FirstName `
           -Surname $LastName `
           -SamAccountName $SamAccountName `
           -UserPrincipalName $UPN `
           -Name $FullName `
           -DisplayName $FullName `
           -Path $OU `
           -EmailAddress $Email `
           -Department $Department `
           -Title $JobTitle `
           -EmployeeID $EmployeeID `
           -AccountPassword $Password `
           -Enabled $true `
           -ChangePasswordAtLogon $false `
           -PassThru

# Set additional attributes
Set-ADUser -Identity $SamAccountName -Replace @{
    proxyAddresses = @($ProxyAddress1, $ProxyAddress2, $ProxyAddress3)
    targetAddress = $TargetAddress
}

# Add user to the MFA-enabled group (Placeholder used)
Add-ADGroupMember -Identity "Your-MFA-Enabled-Group" -Members $SamAccountName 

Write-Host "User $FullName ($SamAccountName) created successfully with email: $Email and UPN: $UPN"
