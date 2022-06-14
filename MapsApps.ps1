#En litt langbeint snutt som lager objekter av alle appene i tenanten. Ble brukt for å mate inn i en appdatabase

$token = 'GraphTokenHer'

function Get-GraphRequestRecursive {
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Graph access token
        [Parameter(Mandatory = $true,
            Position = 0)]
        [String] $AccessToken,

        # Graph url
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            Position = 1)]
        [String] $Url
    )

    Write-Debug "Fetching url $Url"
    $Result = Invoke-RestMethod $Url -Headers @{Authorization = "Bearer $AccessToken" } -Verbose:$false
    if ($Result.value) {
        $Result.value
    }

    # Calls itself when there is a nextlink, in order to get next page
    if ($Result.'@odata.nextLink') {
        Get-GraphRequestRecursive -Url $Result.'@odata.nextLink' -AccessToken $AccessToken
    }
}

$apps = Get-GraphRequestRecursive -AccessToken $token -Url 'https://graph.microsoft.com/beta/deviceAppManagement/mobileApps'
$finarr = @()
$n = $apps.Count

for($i=0;$i -lt $n;$i++){
    if($apps[$i].'@odata.type'  -eq '#microsoft.graph.win32LobApp'){
        $appID = $apps[$i].id
        $assignments = Get-GraphRequestRecursive -url "https://graph.microsoft.com/beta/deviceAppManagement/mobileApps/$appID/assignments" -AccessToken $token
        $uninst = @()
        $required = @()
        $avail = @()
        $m = $assignments.count
        if($assignments.Count -eq $null -and $assignments[0].intent -ne $null){
           $m ++
        }
    
        for($j=0;$j -lt $m;$j++){
        $group = $null
    
            if($assignments[$j].intent -eq 'uninstall'){
                $groupID = $assignments[$j].id.Substring(0,$assignments[$j].id.IndexOf('_'))
                if($groupID -eq 'acacacac-9df4-4c7d-9d50-4ef0226f57a9'){
                    $uninst += 'All Users'
                }
                if($groupID -eq 'adadadad-808e-44e2-905a-0b7873a8a531'){
                    $uninst += 'All Devices'
                }
            
                if(($groupID -ne 'adadadad-808e-44e2-905a-0b7873a8a531') -and ($groupID -ne 'acacacac-9df4-4c7d-9d50-4ef0226f57a9')){
                    $group = Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/Beta/groups/$groupID" -Headers @{Authorization = "Bearer $token"} -Verbose:$false
                    if($uninst -notcontains $group.displayName){
                        $uninst += $group.displayName
                    }
                }
            }
        
            if($assignments[$j].intent -eq 'required'){
                $groupID = $assignments[$j].id.Substring(0,$assignments[$j].id.IndexOf('_'))
                if($groupID -eq 'acacacac-9df4-4c7d-9d50-4ef0226f57a9'){
                    $required += 'All Users'
                }
                if($groupID -eq 'adadadad-808e-44e2-905a-0b7873a8a531'){
                    $required += 'All Devices'
                }
            
                if(($groupID -ne 'adadadad-808e-44e2-905a-0b7873a8a531') -and ($groupID -ne 'acacacac-9df4-4c7d-9d50-4ef0226f57a9')){
                    $group = Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/Beta/groups/$groupID" -Headers @{Authorization = "Bearer $token"} -Verbose:$false
                    if($required -notcontains $group.displayName){
                        $required += $group.displayName
                    } 
                }
            }
    
            if($assignments[$j].intent -eq 'available'){
                $groupID = $assignments[$j].id.Substring(0,$assignments[$j].id.IndexOf('_'))
                if($groupID -eq 'acacacac-9df4-4c7d-9d50-4ef0226f57a9'){
                    $avail += 'All Users'
                }
                if($groupID -eq 'adadadad-808e-44e2-905a-0b7873a8a531'){
                    $avail += 'All Devices'
                }
            
                if(($groupID -ne 'adadadad-808e-44e2-905a-0b7873a8a531') -and ($groupID -ne 'acacacac-9df4-4c7d-9d50-4ef0226f57a9')){
                    $group = Invoke-RestMethod  -Method Get -Uri "https://graph.microsoft.com/Beta/groups/$groupID" -Headers @{Authorization = "Bearer $token"} -Verbose:$false
                    if($avail -notcontains $group.displayName){
                        $avail += $group.displayName
                        }
                    }
                }
            }

        $obj = New-Object PSObject -Property @{  
            ID = $apps[$i].id
            Navn = $apps[$i].displayName
            Description = $apps[$i].description
            InstallCmd = $apps[$i].installCommandLine
            UninstallCmd = $apps[$i].uninstallCommandLine
            Detection = $apps[$i].detectionRules
            GroupAvailable = $avail[0..-1]
            GroupRequired = $required[0..-1]
            GroupUninstall = $uninst[0..-1]
            Apptype = ''
            Version = $apps[$i].displayVersion
            }
        $finarr += $obj
    }
}
