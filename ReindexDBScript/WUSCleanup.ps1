[reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null 
$wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer(); 
$cleanupScope = new-object Microsoft.UpdateServices.Administration.CleanupScope; 
#$cleanupScope.DeclineSupersededUpdates = $true        
#$cleanupScope.DeclineExpiredUpdates = $true 
#$cleanupScope.CleanupObsoleteUpdates = $true 
#$cleanupScope.CompressUpdates = $true 
#$cleanupScope.CleanupObsoleteComputers = $true 
$cleanupScope.CleanupUnneededContentFiles = $true 
$cleanupManager = $wsus.GetCleanupManager(); 
$cleanupManager.PerformCleanup($cleanupScope); 