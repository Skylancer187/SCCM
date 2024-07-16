# Manual General Script to remove files from old 3rd patch management.
# This is an agressive approach and should be used with limits.
# You'll need to clean up the WSUS DB afterwards of the orphaned records.

$list = @()
$filter = "*SoftwareName*"
$date = (Get-Date).AddDays(-90)

#$path = "X:\Path\To\UpdateServicesPackages"
$path = "W:\WSUS\UpdateServicesPackages"

#limit by size
$files = Get-ChildItem -Path "$path" -Filter *.exe -Recurse | Where-Object {($_.lastwritetime -le "$date") -and ($_.length -gt 50MB) -and ($_.name -like "$filter")}

#limit by just name
#$files = Get-ChildItem -Path "$path" -Filter *.exe -Recurse | Where-Object {($_.name -like "$filter")}

#limit by extension
#$files = Get-ChildItem -Path "$path" -Filter *.exe -Recurse

foreach ($f in $files) 
    {
    $a = Split-Path -Path $f.fullname -Parent

    $list += Split-Path -path $a -Parent
    }

    $files | select name, length, lastwritetime | sort lastwritetime
    #$list

foreach ($f in $list)
    {
    Remove-Item -LiteralPath "$f" -Force -Recurse -Verbose
    }