function Start-SPService($ServiceInstanceTypeName) {
	$ServiceInstance = (Get-SPServiceInstance | Where {$_.TypeName -eq $ServiceInstanceTypeName})

	if($ServiceInstance -ne $null -and $ServiceInstance.Status -ne "Online" -and $ServiceInstance.Status -ne "Provisioning") {
        $ServiceInstance | Start-SPServiceInstance 
	}
    else
    {
        Write-Host -ForegroundColor Green "The service $ServiceInstanceTypeName is Online."
    }
	
	$i = 0;
	while(-not ($ServiceInstance.Status -eq "Online") -and $i -lt 10) {
		Write-Host -ForegroundColor Yellow "Waiting for the $ServiceInstanceTypeName service to provision...";
		sleep 100;
		$ServiceInstance = (Get-SPServiceInstance | Where {$_.TypeName -eq $ServiceInstanceTypeName})
		
		$i += 1;
		
		if($i -eq 10) {
			Write-Host -ForegroundColor Yellow "It seems Service $ServiceInstanceTypeName has not yet been provisioned. We will continue with other stuff now."
			
			if($continue -eq "Y") {
				$i = 0;
			}
		}
	}
}

Start-SPService "Word Automation Services"