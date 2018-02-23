Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Web

$JsonObject = New-Object System.Collections.ArrayList



$Form                       = New-Object System.Windows.Forms.Form 
$Button                     = New-Object System.Windows.Forms.Button
$ButtonRefresh              = New-Object System.Windows.Forms.Button
$DropDownKey                = New-Object System.Windows.Forms.ComboBox
$DropDownValue              = New-object System.Windows.Forms.ComboBox
$HeadersKey                 = New-Object System.Collections.ArrayList
$HeadersValue               = New-Object System.Collections.ArrayList
$PropertyGrid               = New-Object System.Windows.Forms.PropertyGrid
$TextBoxUserKeyInput        = New-Object System.Windows.Forms.TextBox
$TextBoxUserValueInput      = New-Object System.Windows.Forms.TextBox
$OKButton                   = New-Object System.Windows.Forms.Button
$CancelButton               = New-Object System.Windows.Forms.Button
$RadioClipBoard             = New-Object System.Windows.Forms.RadioButton
$ResultTextBox              = New-Object System.Windows.Forms.TextBox
$FormFont                   = New-Object System.Drawing.Font("Calibri", 9, [System.Drawing.FontStyle]::Regular)
# $Icon                       = New-Object System.Drawing.Icon("C:\Users\yaron.blum\Desktop\Tools\powershell\cdConstract\bender.ico")

Function CreateLabel 
{
    $Label                  = New-Object System.Windows.Forms.Label
    $Label.Location         = New-Object System.Drawing.Point(0, 40)
    $Label.AutoSize         = $true
    $Label.Text             = "CD Key"
    $script:LabelKey        = $Label
    
    $Label1                 = New-Object System.Windows.Forms.Label
    $Label1.Location        = New-Object System.Drawing.Point(0, 60)
    $Label1.AutoSize        = $true
    $Label1.Text            = "CD Value"
    $script:LabelValue      = $Label1
};

Function PopulateDropDown 
{   
    Write-Host "populating dropdown list.."
    
    $DropDownKey.Items.Clear()
    $DropDownValue.Items.Clear()    

    if ( [string]::IsNullOrEmpty($HeadersKey) -AND ([string]::IsNullOrEmpty($HeadersValue)) ) 
    {
        Write-Host "nothing to write"
    }
    
    else 
    {
        foreach ( $Key in $HeadersKey ) 
        {   
            if( ($Key -NE ";") -AND ($Key -NE ":") )
            {
                $DropDownKey.Items.Add($Key)
            }
        }
        
        foreach ( $Value in $HeadersValue )
        {   
            if( ($Value -NE ";") -AND ($Value -NE ":") )
            {
                $DropDownValue.Items.Add($Value)
            }
        }   
    };
    
    $Form.Controls.Add($DropDownKey)
    $Form.Controls.Add($DropDownValue)
};

Function WriteProgress ($Info, $ItemsToProgress) 
{
    For($i = 0; $i -le $ItemsToProgress; $i++) 
    {
        Write-Progress -Activity "$Info" -Status "$i out of $ItemsToProgress" -PercentComplete ($i / $ItemsToProgress * 100)
    }
}

Function FormTextBox 
{
    if ( -NOT [string]::IsNullOrEmpty($TextBoxUserKeyInput.Text) )
    { 
        $HeadersKey.Add( $TextBoxUserKeyInput.Text   )
        # $HeadersKey.Add(":")
        $HeadersValue.Add( $TextBoxUserValueInput.Text )
        # $HeadersValue.Add(";")
        
        $TextBoxUserKeyInput.Text       = $null
        $TextBoxUserValueInput.Text     = $null
    }
};

Function UserInputContainer 
{
    
    $TextBoxUserKeyInput.Location       = New-Object System.Drawing.Point(55, 40) 
    $TextBoxUserKeyInput.Size           = New-Object System.Drawing.Size(260, 20)
    $TextBoxUserKeyInput.Multiline      = $true
    $TextBoxUserKeyInput.AutoSize       = $true

    $TextBoxUserValueInput.Location     = New-Object System.Drawing.Point(55, 60) 
    $TextBoxUserValueInput.Size         = New-Object System.Drawing.Size(260, 20)
    $TextBoxUserValueInput.Multiline    = $true
    $TextBoxUserValueInput.AutoSize     = $true
    
    $Form.Controls.Add(  $TextBoxUserKeyInput        )
    $Form.Controls.Add(  $TextBoxUserValueInput      )
}

Function RenderResultsTextBox
{
    $ResultTextBox.Location             = New-Object System.Drawing.Point(200, 120)
    $ResultTextBox.Size                 = New-Object System.Drawing.Point(150, 25)
    $ResultTextBox.Multiline            = $True
    $ResultTextBox.AutoSize             = $True
    $ResultTextBox.Dock                 = [System.Windows.Forms.DockStyle]::Bottom
    
    if( [string]::IsNullOrEmpty($ResultTextBox.Text) ) 
    {
        $ResultTextBox.Text = "Waiting for some magic to happen.." 
    }
}

Function FormButtons
{   
    $Button.Location = New-Object System.Drawing.Point(170, 120)
    $Button.Size     = New-Object System.Drawing.Size(90,25)
    $Button.Text     = "Add Object"
    $Button.Add_Click({ FormTextBox })
};

Function RenderRefreshButton 
{
    $ButtonRefresh.Location = New-Object System.Drawing.Point(70, 120)
    $ButtonRefresh.Text     = "Populate"
    $ButtonRefresh.Size     = New-Object System.Drawing.Size(90, 25)
    $ButtonRefresh.Add_Click({ PopulateDropDown })
};

Function RadioButtonCopyToClipBoard 
{
    $RadioClipBoard.Location    = New-Object System.Drawing.Point(300, 100)
    $RadioClipBoard.Text        = "copy"
    $RadioClipBoard.Checked     = $false
    $RadioClipBoard.Add_Click({ $RadioClipBoard.Checked = $True })
};

Function RenderDialogButtons 
{
    $OKButton.Text              = "Ok"
    $OKButton.Location          = New-Object System.Drawing.Point(120, 170)
    $OKButton.Size              = New-Object System.Drawing.Point(75, 23)
    $OKButton.DialogResult      = [System.Windows.Forms.DialogResult]::OK

    $CancelButton.Text          = "Cancel"
    $CancelButton.Location      = New-Object System.Drawing.Point(200, 170)
    $CancelButton.Size          = New-Object System.Drawing.Point(75, 23)
    $CancelButton.DialogResult  = [System.Windows.Forms.DialogResult]::Cancel
};

Function RenderPropertyGrid
{      
    $PropertyGrid.Dock              = [System.Windows.Forms.DockStyle]::Bottom
    $PropertyGrid.Location          = New-Object System.Drawing.Point(140, 350)
    $PropertyGrid.AutoSize          = $true
    $PropertyGrid.SelectedObject    = $Headers
}

Function RenderDropDown 
{
    $DropDownKey.Location           = New-Object System.Drawing.Size(350, 30)
    $DropDownKey.Size               = New-Object System.Drawing.Size(130, 30)
    
    $DropDownValue.Location         = New-Object System.Drawing.Size(350, 60)
    $DropDownValue.Size             = New-Object System.Drawing.Size(130, 30)
}

Function JoinInputKeyAndValue 
{
    for($i = 0; $i -lt $HeadersKey.Count; $i++)
    {
        Write-Host HERE
        $JsonObject.Add($HeadersKey[$i] + """" + ":" + """" + $HeadersValue[$i]) | Out-Null;
        # $JsonObject.Add(":");
        # $JsonObject.Add($HeadersValue[$i] + ",");
        # $JsonObject.Add(",")

    }
        $Object = $JsonObject | ConvertTo-Json  #Out-Host
        [System.Web.HttpUtility]::UrlEncode($Object) | Out-Host


    # Write-Host $HeadersKey[0]
    # Write-Host $HeadersValue[0]
}
   
Function CreateForm ($formTitle) 
{   

    $Form.Text              = $formTitle
    $Form.Size              = New-Object System.Drawing.Size(700,450) 
    $Form.StartPosition     = "CenterScreen"
    $Form.Font              = $FormFont
    # $Form.Icon          = $Icon
    
    FormTextBox
    CreateLabel
    FormButtons
    RenderDropDown
    RenderDialogButtons
    RenderRefreshButton
    RadioButtonCopyToClipBoard
    RenderResultsTextBox
    UserInputContainer
    # RenderPropertyGrid
    
    $Form.AcceptButton   =  $OKButton
    $Form.Controls.Add(     $Button             )
    $Form.Controls.Add(     $DropDown           )
    $Form.Controls.Add(     $ButtonRefresh      )
    $Form.Controls.Add(     $LabelKey           )
    $Form.Controls.Add(     $LabelValue         )
    $Form.Controls.Add(     $OKButton           )
    $Form.Controls.Add(     $CancelButton       )
    $Form.Controls.Add(     $RadioClipBoard     )
    $Form.Controls.Add(     $ResultTextBox      )
    # $Form.Controls.Add(     $PropertyGrid       )
    
    $Form.ShowDialog()
};

Function Main 
{
    CreateForm "CD Constructor"
    
    if( $Form.DialogResult -EQ "OK")
    {
        if ( -NOT [string]::IsNullOrEmpty($HeadersKey) )
        { 
            $HeadersKey     = $HeadersKey.Trim()
            $HeadersValue   = $HeadersValue.Trim()

            $Encoded = [System.Web.HttpUtility]::UrlEncode($HeadersKey + $HeadersValue)
            $ResultTextBox.Text = "As requested, CD object converted: $Encoded" 

            <#to do: create a user prompt for clipboard?#> 
            if( $RadioClipBoard.Checked -EQ $True)
            {
                $Headers | Clip
            }
        }

        JoinInputKeyAndValue
        # Write-Host $JsonObject
        main
    } 

    else 
    {
        WriteProgress "terminating.." 50
    }
};

Main;