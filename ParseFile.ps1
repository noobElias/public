#Parser en textfil tegn for tegn og sammenligner det som er fra før med riktig innhold

$filepath = 'C:\Windows\test.ini'
$gotini = Test-Path $filepath

if($gotini -eq $true){
    $status = $true
    $ini = @("[gmisan]`
blabla
innholdifilen
som er riktig
kan ikke tabbes ut, da blir det rot

")

    $ini = $ini -Split "`r`n" 
    $realini = Get-Content $filepath
    #tester
    for($i=0;$i -lt $realini.Count;$i++){
        if($ini[$i] -ne $realini[$i]){
            $status = $false
        }
    }
    #status
    if($status -eq $true){
        Write-Output 'Compliant'
        exit 0
    }
    if($status -eq $false){
        Write-Output 'Nogood'
        exit 1 
    }
}

if($gotini -eq $false){
    Write-Output "Hadde ikke ini-fil..jeg gjÃ¸r ingenting"
    exit 0
}
