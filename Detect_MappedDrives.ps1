#Hardkodet detection, sjekker om klienten har fått mappet opp nettverksdiskene riktig 

$drives = Get-PSDrive -PSProvider FileSystem | Select-Object name, @{n="Root"; e={if ($_.DisplayRoot -eq $null) {$_.Root} else {$_.DisplayRoot}}}
$drives = $drives[1..$drives.count]
$m = $drives.Count
$status = $false
$res = @('U', 'G', 'I', 'M', 'K')
$n = $res.Count
$c = 0
for($i=0;$i -lt $n;$i++){
    for($j=0;$j -lt $m;$j++){
        if($drives[$i].Name -eq $res[$j]){
            $c ++
        }
    }
    if($c -eq $n){
        $status = $true
    }
}
if($status -eq $true){
    Write-Output 'Compliant'
    exit 0
}
else{
    Write-Output $drives
    exit 1
}
