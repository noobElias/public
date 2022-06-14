function startspill{
    $count = 0
    writeboard
    place
}

$board = @("_____","*","*","*","*","*","*","*","*","*","-----")

function writeboard{
    Write-Host $board[0]
    Write-Host $board[1],$board[2],$board[3]
    Write-Host $board[4],$board[5],$board[6]
    Write-Host $board[7],$board[8],$board[9]
    Write-Host $board[10]
}

function checkwin{
    if ($board[1] -and $board[2] -and $board[3] -notcontains "*" -and $board[1] -and $board[2] -and $board[3] -eq $marker -and $board[1] -eq $board[2] -and $board[2] -eq $board[3]){
        return $true
    }
    if ($board[4] -and $board[5] -and $board[6] -notcontains "*" -and $board[4] -and $board[5] -and $board[6] -eq $marker -and $board[4] -eq $board[5] -and $board[5] -eq $board[6]){
        return $true
    }
    if ($board[7] -and $board[8] -and $board[9] -notcontains "*" -and $board[7] -and $board[8] -and $board[9] -eq $marker -and $board[7] -eq $board[8] -and $board[8] -eq $board[9]){
        return $true
    }
    if ($board[1] -and $board[4] -and $board[7] -notcontains "*" -and $board[1] -and $board[4] -and $board[7] -eq $marker -and $board[1] -eq $board[4] -and $board[4] -eq $board[7]){
        return $true
    }
    if ($board[2] -and $board[5] -and $board[8] -notcontains "*" -and $board[2] -and $board[5] -and $board[8] -eq $marker -and $board[2] -eq $board[5] -and $board[5] -eq $board[8]){
        return $true
    }
    if ($board[3] -and $board[6] -and $board[9] -notcontains "*" -and $board[3] -and $board[6] -and $board[9] -eq $marker -and $board[3] -eq $board[6] -and $board[6] -eq $board[9]){
        return $true
    }
    if ($board[1] -and $board[5] -and $board[9] -notcontains "*" -and $board[1] -and $board[5] -and $board[9] -eq $marker -and $board[1] -eq $board[5] -and $board[5] -eq $board[9]){
        return $true
    }
    if ($board[3] -and $board[5] -and $board[7] -notcontains "*" -and $board[3] -and $board[5] -and $board[7] -eq $marker -and $board[3] -eq $board[5] -and $board[5] -eq $board[7]){
        return $true
    }
}

function place{
    $nc = $false
    if($count%2 -eq "0"){
        $marker = "X"
    }
    if($count%2 -ne "0"){
        $marker = "O"
    }
    $b = Read-Host "$marker 1-9"
    $tmp = $board[$b]
    if($tmp -ne "*"){
        Write-Host "ulovelig move amigo :/"
        $nc = $true
    }
    $tmp = $tmp.Replace("*","$marker")
    $board[$b] = $tmp
    if($nc -eq $false){
        $count = $count + 1
    }
    writeboard
    checkwin
    if(checkwin){
        $count = 9
        Write-Host "$marker vant!!!"
    }
    if($count -le 8){
        place
    }
}
startspill
