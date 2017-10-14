   Configuration Example 
    {
        param(
            [Parameter(Mandatory = $true)]
            [PSCredential]
            $SetupAccount
        )
        Import-DscResource -ModuleName SharePointDsc

        node localhost {
            SPAlternateUrl CentralAdminAAM
            {
                WebAppUrl            = "http://sp16portal.test.local"
                Zone                 = "Custom"
                Url                  = "http://portal"
                PsDscRunAsCredential = $SetupAccount
            }
        }
    }

$cd = @{
    AllNodes = @(
        @{
            NodeName = 'localhost'
            PSDscAllowPlainTextPassword = $true
        }
    )
}


# . .\demo6a.ps1
# Example            
            
# Start-DscConfiguration -Path .\ScriptTest -Wait -Verbose            
# Remove-DscConfigurationDocument -Stage Pending

# Get-DscConfiguration 