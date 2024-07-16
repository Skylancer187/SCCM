    $WsusServer = "WSUS-SERVER.fqdn.com"
    $WsusPort = "8531"


    $CleanUpJobs = @("CleanupObsoleteComputers","DeclineExpiredUpdates","DeclineSupersededUpdates","CleanupObsoleteUpdates","CleanupUnneededContentFiles")

    ForEach ($CleanUpJob in $CleanUpJobs)
    {
        Write-Host "$CleanUpJob..."
        try {
            Invoke-Expression "Get-WsusServer -Name $WsusServer -PortNumber $WsusPort -UseSsl | Invoke-WsusServerCleanup -$CleanUpJob"
        }
        catch {
            Write-Host $_.Exception.Message
        }
    }