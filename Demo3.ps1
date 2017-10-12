#Modules

Install-Module -Name SharePointPnPPowerShellOnline
Install-Module -Name SharePointDSC
Install-Module -Name SharePointDSC.Reverse

Get-Module SharePointPnPPowerShell* -ListAvailable | Select-Object Name,Version | Sort-Object Version -Descending

Update-Module SharePointPnPPowerShell*