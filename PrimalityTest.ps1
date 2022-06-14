#primality test brukt i ProjectEular
function isprime{
    param ($n)
    if($n -le 1){
        return $false
    }
    
    if($n -le 3){
        return $true
    }

    if(($n%2 -eq 0) -or ($n%3 -eq 0)){
        return $false
    }
    
    for($i=5;$i*$i -le $n;$i=$i+=6){
        if($n%$i -eq 0 -or $n %($i+2) -eq 0){
            return $false
        }
    }
    return $true

}

$primes = 0

for($i = 0;$i -lt 2000000;$i++){
    if(isprime -n $i -eq $true){
        $primes = $primes + $i
    }

}
