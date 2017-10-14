Function Create-SPMockupSites($Path)
{
    $webTemplates = Get-SPWebTemplate | Where{$_.IsHidden -eq $false -and $_.IsRootWebOnly -eq $false -and $_.CompatibilityLevel -eq 15 -and $_.Name -ne "BICenterSite#0" -and $_.Name -ne "EDISC#1"}
    New-SPWeb -url ($Path + "/templates") -Template "STS#1" -Name "Templates"
    $rootWeb = Get-SPWeb ($Path + "/templates")

    ForEach($webTemplate in $webTemplates)
    {
		$templateName = ($webTemplate.Title -replace '\s', '')

        $url = $rootWeb.Url + "/" + $templateName;
        $exists = (Get-SPWeb $url -ErrorAction SilentlyContinue) -ne $null

        if($exists)
        {
            Write-Host -ForegroundColor Green "The web $url already exists."
        }
        else
        {
            New-SPWeb -url ($url) -Template $webTemplate.Name -Name $webTemplate.Title -Description $webTemplate.Description
        }
    }
}

# Completely deletes the specified Web (including all subsites)

function RemoveSPWebRecursively(
    [Microsoft.SharePoint.SPWeb] $web)
{
    Write-Debug "Removing site ($($web.Url))..."
    
    $subwebs = $web.GetSubwebsForCurrentUser()
    
    foreach($subweb in $subwebs)
    {
        RemoveSPWebRecursively($subweb)
        $subweb.Dispose()
    }
    
    $DebugPreference = "SilentlyContinue"
    Remove-SPWeb $web -Confirm:$false
    $DebugPreference = "Continue"
}

#To use the preceding code, type the following:
$siteUrl = Read-Host "Howdy, please enter your site collection URL"
Create-SPMockupSites $siteUrl

Read-Host "Press any key to proceed..."

$web = Get-SPWeb "$siteUrl/templates"
RemoveSPWebRecursively $web