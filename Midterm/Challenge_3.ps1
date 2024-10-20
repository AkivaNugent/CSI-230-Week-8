. (Join-Path $PSScriptRoot Challenge_2.ps1)

$indicators = @(
            "/index.php?/bin/sh+simplebackdoor.bash",
            "/index.php?a=1+OR+1=1--",
            "/index.php?cmd=/bin/bash+myscript.bash",
            "/index.php?cmd=/bin/sh+simplebackdoor.bash",
            "/index.php?cmd=/bing/bash+myscript.bash",
            "/index.php?cmd=cat+etc/passwd",
            "/index.php?cmd=etc/passwd",
            "/index.html?command=/bin/bash/+midtermcheatdetector.bash",
            "/index.html?command=/bin/bash/+reverseshell.bash"
            )

$allLogs = ApacheLogs

function indicatedLogs ($allLogs, $indicators){
    $indicatedList = @()

    for ($i = 0; $i -lt $indicators.Count; $i++){
        for ($j = 0; $j -lt $allLogs.Count; $j++) {
            if($allLogs[$j].Page -eq $indicators[$i]) {
                $indicatedList += $allLogs[$j]
            }
        }
    }
    return $indicatedList
}


$indicatedLogs = indicatedLogs $allLogs $indicators

$indicatedLogs | Format-Table -AutoSize