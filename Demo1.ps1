Get-SPSite

Get-Help Get-SPSite

$SiteCollection = Get-SPSite "http://sp16site.contoso.com"
$SiteCollection.Url
$SiteCollection.Owner 

Get-SPSite | Get-SPWeb

Get-SPService | Select *

Get-SPSite | Where {$_.Url -like "*contoso*"}

Get-SPSite -Limit ALL

Get-SPSite | Out-GridView

Get-SPSite | Out-File C:\Temp\demo1.txt
C:\Temp\demo1.txt