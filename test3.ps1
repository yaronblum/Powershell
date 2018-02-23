Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
$form                   = New-Object System.Windows.Forms.Form 
$form.Text          = $formTitle
    $form.Size          = New-Object System.Drawing.Size(400,200) 
    $form.StartPosition = "CenterScreen"
$DropDown = new-object System.Windows.Forms.ComboBox
$DropDown.Location = new-object System.Drawing.Size(100,10)
$DropDown.Size = new-object System.Drawing.Size(130,30)

$DropDownArray = Get-Content("c:\Users\yaron.blum\Desktop\Tools\powershell\cdConstract\cdConstructor.json") | convertfrom-json
ForEach ($Item in $DropDownArray) {
    $DropDown.Items.Add($Item)
}

start
$Form.Controls.Add($DropDown)
$form.ShowDialog()