Function Show-Object
{
    param
    (
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [Object]
        $InputObject,

        $Title
    )
    Add-Type -AssemblyName System.Windows.Forms    
    Add-Type -AssemblyName System.Drawing

    if (!$Title) { $Title = "$InputObject" }
    $Form = New-Object "System.Windows.Forms.Form"
    $Form.Size = New-Object System.Drawing.Size @(600,600)
    $PropertyGrid = New-Object System.Windows.Forms.PropertyGrid
    $PropertyGrid.Dock = [System.Windows.Forms.DockStyle]::Fill
    $Form.Text = $Title
    $PropertyGrid.SelectedObject = $InputObject | Select *
    $PropertyGrid.PropertySort = 'Alphabetical'
    $Form.Controls.Add($PropertyGrid)
    $Form.TopMost = $true
    $null = $Form.ShowDialog()
} 


$url = "https://ape-orange.isappcloud.com/feeds/1fe4c223-bd62-47c1-8498-2b3a7ff3bd5c?tk=f1e47d53da52e5b3608dd8d658f80467ce45f2c5bd3aeb41989198d1cf46cc95&cd=%7b+%22ab%22%3a+%22orange%22%2c+%22ac%22%3a+%22orange%22%2c+%22ae%22%3a+%22orange%22%2c+%22apiv%22%3a+20150330%2c+%22cid%22%3a+%22com.ironsource.aura.sdk.tester%22%2c+%22cv%22%3a+%221.0.0%22%2c+%22cvc%22%3a+%22100%22%2c+%22d%22%3a+%22v3971%22%2c+%22das%22%3a+%2225455030272%22%2c+%22db%22%3a+%22WIKO%22%2c+%22dc%22%3a+%22Hardware%5ct%3a+MT6737%22%2c+%22dma%22%3a+%22WIKO%22%2c+%22dmo%22%3a+%22U+PULSE+LITE%22%2c+%22dp%22%3a+%22v3971%22%2c+%22dr%22%3a+%22MemTotal%3a++++++++2969092+kB%22%2c+%22dts%22%3a+%2226316500992%22%2c+%22gaid%22%3a+%2232a27444-dbf6-4b9e-8a13-06b2b7a7c271%22%2c+%22l%22%3a+%22en_US%22%2c+%22late%22%3a+%22false%22%2c+%22nt%22%3a+%22wifi%22%2c+%22os%22%3a+%22Android%22%2c+%22osfp%22%3a+%22TINNO%2fv3971%2fv3971%3a7.0%2fNRD90M%2f%3auser%2frelease-keys%22%2c+%22osv%22%3a+%227.0%22%2c+%22osvc%22%3a+%2224%22%2c+%22pr%22%3a+%22sdk%22%2c+%22prvc%22%3a+13000%2c+%22prvn%22%3a+%221.3.0%22+%7d"
$RequestIt = Invoke-WebRequest -URI $url -Headers @{"X-CC"="$xcc"}
$response = $RequestIt | ConvertFrom-Json 
$Headers = New-Object System.Collections.ArrayList

$foo = foreach ($feed in $response.feeds) {
    $feed.apps | Select *
}
Add-Type -AssemblyName System.Windows.Forms    
# Add-Type -AssemblyName System.Drawing

$Form = New-Object "System.Windows.Forms.Form"
# $Form.Size = New-Object System.Drawing.Size @(600,600)
   
$PropertyGrid = New-Object System.Windows.Forms.PropertyGrid
$PropertyGrid.Dock = [System.Windows.Forms.DockStyle]::Fill
$PropertyGrid.SelectedObject = $foo
$Form.Controls.Add($PropertyGrid)
# $null = $Form.ShowDialog()
$foo | Out-GridView -Wait 
# pause

# $response.feeds.apps
# $response.feeds[1].apps

# $response.feeds[2].apps
# foreach ( $key in $response.feeds.apps ) 
# {
#     $Headers.Add($key)
#     Write-Host $key
# }  

# Write-Host $Headers