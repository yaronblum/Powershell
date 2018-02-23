Function WriteProgress ($ItemsToProgress) {
    For($i = 0; $i -le $ItemsToProgress.Length; $i++) { 
        Write-Progress -Activity "Parsing Request..."  -Status "Parsed $i out of $ItemsToProgress.Length" -percentComplete ($i / $ItemsToProgress.Length * 100)
    }
}

Function WriteProgress2 {
    [CmdletBinding()]
    Param(
        [parameter(ValueFromPipelineByPropertyName)]
        [int[]]$Integer
        )
        Process {
            $_
        }