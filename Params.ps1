param (
          [string] $Bar = 'test'
        , [string] $Baz
        , [string] $Asdf
    )
    # Get the command name
    $CommandName = $PSCmdlet.MyInvocation.BoundParameters;
    # Get the list of parameters for the command
    $ParameterList = (Get-Command -Name $CommandName).Parameters;

    # Grab each parameter value, using Get-Variable
    foreach ($Parameter in $ParameterList) {
        Get-Variable -Name $Parameter.Values.Name -ErrorAction SilentlyContinue;
        #Get-Variable -Name $ParameterList;

    }

# test -asdf blah;