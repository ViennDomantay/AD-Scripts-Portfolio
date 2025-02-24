import-module activedirectory

#input hostname and domain#
$servers = "your-dc.yourcompany.com"

$subject= "ADList"

foreach($server in $($servers.split(","))) 
{
    $logfile = "C:\Scripts\UAM\ADList\ADList_"+$server+".csv"

	Get-ADUser -Filter * -Server $server -Properties Enabled,DisplayName,name,description,givenname,sn,Title,DistinguishedName,whenCreated,mail,employeeNumber,samaccountname,whenChanged,userprincipalname,LastlogonDate,employeeid,physicalDeliveryOfficeName,dfserviceaccount,department,telephoneNumber,dfstorearea,dfstoreregion,streetAddress,expirationTime,Company,OfficePhone,Manager | select Enabled,DisplayName,name,description,givenname,sn,Title,DistinguishedName,whenCreated,mail,employeeNumber,samaccountname,whenChanged,userprincipalname,LastlogonDate,employeeid,physicalDeliveryOfficeName,dfserviceaccount,department,telephoneNumber,dfstorearea,dfstoreregion,streetAddress,expirationTime,Company,OfficePhone,@{Name = "Manager";Expression = {%{(Get-AdUser $_.Manager -Properties DisplayName).DisplayName}}} | Export-CSV -path $logfile 

    $attachments += $logfile

}
