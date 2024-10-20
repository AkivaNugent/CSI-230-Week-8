function ApacheLogs(){
    $logEntries = Get-Content C:\CSI230\CSI-230-Week-8\Midterm\access.log
    $regex = '^(?<IP>\S+) - - \[(?<Time>[^\]]+)-\d{4}\] "(?<Method>\S+) (?<Page>\S+) (?<Protocol>\S+)" (?<Response>\d+) \d+ "(?<Referrer>[^"]+)"'
    
    $logs = @()
    for ($i=0; $i -lt $logEntries.Count; $i++){
        
        if ($logEntries[$i] -match $regex) {
            
            $logs += [pscustomobject]@{
                                        IP        = $matches['IP']
                                        Time      = $matches['Time']
                                        Method    = $matches['Method']
                                        Page      = $matches['Page']
                                        Protocol  = $matches['Protocol']
                                        Response  = $matches['Response']
                                        Referrer  = $matches['Referrer']
            }
        }
    }
    return $logs
}

#ApacheLogs | Format-Table -AutoSize