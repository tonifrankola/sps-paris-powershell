Install-Module -Name SharePointPnPPowerShellOnline

Connect-PnPOnline –Url https://M365x167444.sharepoint.com –Credentials (Get-Credential)

$ct = Get-PnPContentType "Document"
Add-PnPContentType -Name "Project Document" -Description "Use for Contoso projects" -Group "Contoso Content Types" -ParentContentType $ct

Get-PnpTheme

Set-PnPTheme -ColorPaletteUrl /_catalogs/theme/15/palette002.spcolor
Set-PnPTheme -ColorPaletteUrl /_catalogs/theme/15/palette002.spcolor

Add-PnPNavigationNode -Title "Demo" -Url "/" -Location "QuickLaunch"

New-PnPList -Title Demo -Template Custom

Add-PnPField -List "Demo" -DisplayName "FirstName" -InternalName "FirstName" -Type Text
Add-PnPField -List "Demo" -DisplayName "LastName" -InternalName "LastName" -Type Text

Add-PnPListItem -List "Demo" -Values @{"Title" = "Mr"; "FirstName" = "Emmanuel"; "LastName" = "Macron"} -ContentType "Item"