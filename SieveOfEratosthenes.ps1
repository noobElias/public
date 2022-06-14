#fin for opp mot 4 siffer med primtall men treg etter det, brukt i ProjectEular 
$n = 100
$a = @()
$sq = $n*$n

for($i=0;$i -lt $n;$i++){
    $a += $true
}

for($i=2; $i -lt $sq;$i++){
    if($a[$i] -eq $true){
        $j = $i * $i
        while($j -lt $n){
            $a[$j] = $false
            $j = $j+$i
        }
    }
}

$primes = @()
for($i=2;$i -lt $a.Count+1;$i++){
    if($a[$i] -eq $true){
        $primes += $i
    }
}

$primes.Count
