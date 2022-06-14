#bubblesort implementert i ps :) 
function sorter($A){
$n = $A.length
for($i=1; $i -le ($n-1);$i++){
    for($j=0; $j -le ($n-$i-1);$j++){
        if($A[$j]-le $A[$j+1]){
            $temp = $A[$j]
            $A[$j] = $A[$j+1]
            $A[$j+1] = $temp

            }
        
        }

    }
return $A
}
