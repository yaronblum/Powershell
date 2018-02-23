# Send config request to custom 
Param (
        [switch]$staging,
        [switch]$debug,
        [string]$brand      = "asus",
        [string]$apeCommand = "config",
        [string]$TokenType  = "Client",
        [string]$cv                 = "7.4.14",
        [string]$ID         = $null,
        [string]$url,
        [string]$tk,
        [string]$xcc,
        [string]$field
    )

##New-Variable -Name Parameters -Value $MyInvocation.BoundParameters -Option ReadOnly;

Function Main {
    
    CollectParams;
    SendRequest;
};

Function SetClientData {
    
    $uid = [guid]::NewGuid()
    $did = [guid]::NewGuid()
    
    [array]$cd = @"
    {"l":"en-us","sl":"en-us","apiv":20151125,"sapiv":20151223,"ab": "panasonic"}
"@  
    
    Set-Variable -Name cd -Value $cd.trim() -Scope 1;
};

Function SetHosts {

    if($staging) {
    
        Set-Variable -Name ApeHost -Value "-staging" -Scope 1
        GetSomeDebug "-- Info: Staging flag set to true, using staging values"

    } else {
        
        Set-Variable -Name ApeHost -Value $NULL -Scope 1
        GetSomeDebug "-- Info: Staging flag is not set to true, using default value for production"
    }
};

Function SetTokens {
    
        try {
            $PathToJson = $PSScriptRoot + "\tokens.json"
            $JsonValues = Get-Content $PathToJson | ConvertFrom-Json;
            
            Set-Variable -Name tk -Value $JsonValues.$brand.$TokenType -Scope 1;

        } catch { ErrorConstructor $_ };

};



Function UrlConstructor {
    
    SetTokens;
    SetCommand;
    SetHosts;
    SetClientData;
    $cd = "%7B%22l%22%3A%22pl_PL%22%2C%22ab%22%3A%22orange%22%2C%22ac%22%3A%22orangepl-sdk%22%2C%22ae%22%3A%22orange%22%2C%22apiv%22%3A20150330%2C%22cid%22%3A%22com.orange.update%22%2C%22cv%22%3A%224.0.4%22%2C%22cvc%22%3A%226180%22%2C%22os%22%3A%22Android%22%2C%22osv%22%3A%225.0.1%22%2C%22osvc%22%3A%2221%22%2C%22osfp%22%3A%22lge%5C%2Fc70n_global_com%5C%2Fc70n%3A5.0.1%5C%2FLRX21Y%5C%2F1532314473156%3Auser%5C%2Frelease-keys%22%2C%22d%22%3A%22c70n%22%2C%22dmo%22%3A%22LG-H440n%22%2C%22dma%22%3A%22LGE%22%2C%22dp%22%3A%22c70n_global_com%22%2C%22db%22%3A%22lge%22%2C%22dr%22%3A%22MemTotal%3A%20%20%20%20%20%20%20%20%20918492%20kB%22%2C%22dts%22%3A%223713302528%22%2C%22das%22%3A%223066122240%22%2C%22dc%22%3A%22Hardware%5Ct%3A%20Qualcomm%20Technologies%2C%20Inc%20MSM8916%22%2C%22smm%22%3A%2226003%22%2C%22so%22%3A%22Orange%22%2C%22nmm%22%3A%2226003%22%2C%22no%22%3A%22Orange%22%2C%22nt%22%3A%22mobile%20(4g)%22%2C%22gaid%22%3A%229b6deece-308a-4927-98db-ca5b82463cf6%22%2C%22late%22%3A%22false%22%2C%22oct%22%3A%22%22%7D" 
    #"%7B%0A%20%20%22l%22%3A%20%22en_GB%22%2C%0A%20%20%22gaid%22%3A%20%2297572342-a909-4572-bde3-cfa124525a20%22%2C%0A%20%20%22late%22%3A%20%22false%22%2C%0A%20%20%22ap%22%3A%20%22preloaded%20apk%22%2C%0A%20%20%22ab%22%3A%20%22htc%22%2C%0A%20%20%22cv%22%3A%20%222.17.1%22%2C%0A%20%20%22apiv%22%3A%2020150330%2C%0A%20%20%22cid%22%3A%20%22com.ironsource.appcloud.oobe.htc%22%2C%0A%20%20%22cvc%22%3A%20%2221710%22%2C%0A%20%20%22os%22%3A%20%22Android%22%2C%0A%20%20%22osv%22%3A%20%226.0.1%22%2C%0A%20%20%22osvc%22%3A%20%2223%22%2C%0A%20%20%22osfp%22%3A%20%22htc%2Fa56uhl_00773%2Fhtc_a56uhl%3A6.0.1%2FMMB29M%2F775199.42%3Auser%2Frelease-keys%22%2C%0A%20%20%22d%22%3A%20%22htc_a56uhl%22%2C%0A%20%20%22dmo%22%3A%20%22HTC%20Desire%20825%22%2C%0A%20%20%22dma%22%3A%20%22HTC%22%2C%0A%20%20%22dp%22%3A%20%22a56uhl_00773%22%2C%0A%20%20%22db%22%3A%20%22htc%22%2C%0A%20%20%22dr%22%3A%20%22MemTotal%3A%20%20%20%20%20%20%20%201885772%20kB%22%2C%0A%20%20%22dts%22%3A%20%2211629592576%22%2C%0A%20%20%22das%22%3A%20%221259683840%22%2C%0A%20%20%22dc%22%3A%20%22Hardware%5Ct%3A%20Qualcomm%20MSM8928%22%2C%0A%20%20%22dcsa%22%3A%20%5B%0A%20%20%20%20%22armeabi-v7a%22%2C%0A%20%20%20%20%22armeabi%22%0A%20%20%5D%2C%0A%20%20%22smm%22%3A%20%2227205%22%2C%0A%20%20%22nmm%22%3A%20%2227205%22%2C%0A%20%20%22no%22%3A%20%223%22%2C%0A%20%20%22nt%22%3A%20%22wifi%22%2C%0A%20%20%22cshl%22%3A%20%22-1838775750%22%2C%0A%20%20%22rv%22%3A%20%221.05.773.42%22%2C%0A%20%20%22src%22%3A%20%22pre-install%22%2C%0A%20%20%22abt%22%3A%20389%2C%0A%20%20%22ippa%22%3A%20true%2C%0A%20%20%22uuid%22%3A%20%222e472634-b0ca-483b-8a2a-d0d577c2a593%22%2C%0A%20%20%22ae%22%3A%20%22htc%22%2C%0A%20%20%22firsttime%22%3A%20%22false%22%2C%0A%20%20%22ac%22%3A%20%22htc%22%0A%7D"
    $url = "https://ape-{0}{1}.isappcloud.com/{2}?tk={3}&cd={4}&field=token" -F $brand,
    $ApeHost,
    $apeCommand,
    $tk,
    # [System.Web.HttpUtility]::UrlEncode($CD),
    $cd,
    $field

    Set-Variable -Name url -Value $url -Scope 1
};

Function SendRequest {
    
    UrlConstructor
    
    GetSomeDebug "-- Info: Getting $($apeCommand) from $($brand)$($ApeHost)"
    GetSomeDebug $url "`n" -NoNewLine
    GetSomeDebug "-- Info: Verify if status code = 200 `n";
            
            try 
            {
                
                $RequestIt = Invoke-WebRequest -URI $url -Headers @{"X-CC"="$xcc"}
                if($RequestIt.statuscode -eq 200)
                {   
                    $GetResponseLength = $RequestIt.content.length
                    for ($i = 1; $i -le $GetResponseLength ; $i++) {
                        Write-Progress -Activity "Parsing Request" -Status "Parsed $i out of $GetResponseLength " -PercentComplete ($i / $GetResponseLength * 100)
                    }
                    if( $apeCommand -eq 'feeds/' + $ID -or
                        $apeCommand -eq 'feed/' + $ID) {

                            $data = $RequestIt.Content | ConvertFrom-Json                             
                            $data.feeds.apps | Out-String -Width 4096
                            "---------------------------------"
                            $data | Format-Table | Out-String -Width 4096
                        
                        } else {
                            
                            $FormatIt = $RequestIt.Content | ConvertFrom-Json  
                            $FormatIt | Out-String -Width 4096
                        } 
                }
            
            } catch { ErrorConstructor $_ };    
};

Function GetVarType ($VarParam, $VarName) {

    $VarParamType = $VarParam.getType().Name;
    
    if([string]::IsNullOrEmpty($VarParam)) { continue

    } else {
        
        Write-Host "-- Info:" $VarName "=" $VarParam ":: From type" $VarParamType -ForegroundColor:Green;
    }
};

Function CollectParams {
    
    foreach($Parameter in $Parameters) {
        Write-Host $Parameter
    }

    Write-Host
    "**************************************"
    Write-Host 
    "--------------------------------------"     
};

Function SetCommand {
    
    if( $apeCommand -eq 'feed'  -or 
        $apeCommand -eq 'feeds' -or 
        $apeCommand -eq 'apps')
    
    {
        [string]$script:apeCommand = $apeCommand + "/" + $ID  
    } 

    elseif( $apeCommand -eq 'config') 

    {
        [string]$script:apeCommand = $apeCommand;
    }

    else 
    
    {
        throw ("***ERROR:Unable to find ApeCommand***");
    };


};

Function DisplayProgressBar ($ActivityMessage)   {
    
    Write-Progress -Activity "$ActivityMessage" -Status "Parsed $i out of $GetResponseLength " -PercentComplete ($i / $GetResponseLength * 100)
}

Function GetSomeDebug ( $SomeDebugToGet ) {

    if($debug) {

        Write-Host
        Write-Host "--DEBUG: " $SomeDebugToGet -ForegroundColor:DarkGreen;
        Write-Host
    }
};


Function ErrorConstructor ($_) {
    
    $console = $host.UI.RawUI 
    $console.ForegroundColor = "Red"

    $_.Exception
    $_.CategoryInfo
    $_.ScriptStackTrace
    
    $console.ForegroundColor = "Gray"
    
    Break;

};

main;