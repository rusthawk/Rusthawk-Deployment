﻿#Force LCM to process a pending metaconfig.mof file by calling the CimMethod

function StartLCM
{
	param(
        [ValidateSet(1,2,3)]
	    [system.uint32]$flag = 1
    )
    
    $CimArguments = @{
        "Namespace" = "root/microsoft/windows/desiredstateconfiguration"
        "ClassName" = "MSFT_DSCLocalConfigurationManager"
        "Name" = "PerformRequiredConfigurationChecks"
        "Arguments" = @{Flags = $flag}
        "Verbose" = $true
    }
	Invoke-CimMethod -Namespace "root/microsoft/windows/desiredstateconfiguration" -ClassName "MSFT_DSCLocalConfigurationManager" -MethodName "PerformRequiredConfigurationChecks" -Arguments @{Flags = $flag} -Verbose
}

StartLCM

Import-Certificate -FilePath "$env:SystemDrive\Scripts\rootcert.crt" -CertStoreLocation "Cert:\LocalMachine\root"

Remove-Item "$env:SystemDrive\Scripts" -Force -Recurse
