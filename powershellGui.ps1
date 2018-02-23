# param([switch]$debug)
try 
{
    . ("$PSScriptRoot\Api_whisperer.ps1")
    . ("$PSScriptRoot\writeprogress.ps1")
    . ("$PSScriptRoot\ImportCSV.ps1")
} 

catch 
{
    Write-Host "Error while loading supporting PowerShell Scripts"
}


Function Generate-Form {

    Add-Type -AssemblyName System.Windows.Forms    
    Add-Type -AssemblyName System.Drawing

    $Headers = New-Object System.Collections.ArrayList

        # Build Form
    $Form = New-Object System.Windows.Forms.Form 
    $Form.Text = "Api Whisperer"
    $Form.Size = New-Object System.Drawing.Size(700,550)
    $Form.StartPosition = "CenterScreen"
    $Form.Topmost = $True

    # Add Button
    $Button = New-Object System.Windows.Forms.Button
    $Button.Location = New-Object System.Drawing.Size(35,35)
    $Button.Size = New-Object System.Drawing.Size(120,23)
    $Button.Text = "Show Dialog Box"

    $ListBox = New-Object System.Windows.Forms.ListBox 
    $ListBox.Location = New-Object System.Drawing.Size(10,70) 
    $ListBox.Size = New-Object System.Drawing.Size(650,300) 
    $ListBox.SelectionMode = 2;
    $ListBox.Sorted = 2;
    $Form.Controls.Add($Button)
    $Form.Controls.Add($ListBox)


    #Add Button event 
    $Button.Add_Click(
        {    
            # $DataTable = New-Object System.Data.DataTable("response")
            $Headers = New-Object System.Collections.ArrayList

            # $cols = @("Key", "Value");

            # foreach ($col in $cols) 
            # {
            #     $DataTable.Columns.Add($col) | Out-Null
            # }

            $ResponseCSV = SendRequest 
            # $ResponseCSV.Count | Out-Host
            # pause
            # get response keys
            for ( $i = 0 ; $i -lt $ResponseCSV.Length ; $i++ )
            {   
                [string]$CurrentItem = $ResponseCSV[$i];
                $Splited = $CurrentItem.Split(":", 2) | Out-Host;
                
                try 
                {
                    # $Headers.Add($Splited[0]) 
                    # $ValueHeaders.Add($Splited[1]);
                }

                catch 
                { 
                    Write-Host "Error:" $_  
                }   
            }
            
            # for ($i = 0 ; $i -lt $Headers.Count ; $i++) 
            # {
            #     try 
            #     {
            #         # $ListBox.Items.Add($Headers[$i])
            #     }
            #     catch 
            #     {
            #         $_
            #     }
            # }
            
             $Headers | Out-gridview

        })
    
    #Show the Form 
    $form.ShowDialog()| Out-Null 
};

Generate-Form