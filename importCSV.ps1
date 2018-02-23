try
{
    .  ("$PSScriptRoot\Api_whisperer.ps1")
}
catch 
{
    Write-Host "Error while loading supporting PowerShell Scripts"
}




function populateGrid {
    
    # pause
    $Headers = New-Object System.Collections.ArrayList
    $RepsonseCSV = SendRequest | ConvertFrom-Csv
    for ($i = 0; $i -le $RepsonseCSV.Count; $i ++) {
        
        [string]$CurrentItem = $RepsonseCSV.H1[$i]
        $Splited = $CurrentItem.Split(":", 2);
        $Splited[0] | Out-String -Width 4096 | Out-GridView
    }
    # return $Headers
}

# populateGrid