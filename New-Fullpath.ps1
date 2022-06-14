#fin for når du trenger en bestemt sti på en klient (c:\temp\test\1\blabla) men du ikke vet hva du har fra før. kan brukes både for dirs og i registeret 
function New-Fullpath{
    param([string]$path)
    $tmppath = $path.Split("\")
    $n = $tmppath.Count
    [string]$newpath = $null
    for($i=0;$i -lt $n;$i++){
        $newpath += $tmppath[$i]+"\"
        if(-not(Test-Path $newpath)){
            New-Item $newpath #Om funksjonen skal bruker til mekking av Dir brukes denne, om den skal brukes til mekking av REG brukes den ikke -ItemType Directory
        }
    }
}
