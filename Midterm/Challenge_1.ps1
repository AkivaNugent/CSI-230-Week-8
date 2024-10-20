function scrapeTableHTMLFromPage($url) {
    $page = Invoke-WebRequest -Uri $url
    $table = $page.ParsedHtml.body.getElementsByTagName("table")

    return $table
}
# I wanted to make this function work more generally with any basic HTML table
function convertHTMLTableToPSTable ($table) {
    $headers = $table.getElementsByTagName("th")
    $rows = $table.getElementsByTagName("tr") | Select-Object -Skip 1

    $colNames = @()
    foreach ($header in $headers) {
        $colNames += $header.innerText
    }

    $FullTable  = @()

    foreach ($row in $rows) {
        $cells = $row.getElementsByTagName("td")
        
        if ($cells.Length -gt 0) {
            $rowObject = New-Object PSObject

            for ($i = 0; $i -lt $cells.Length; $i++) {
                $rowObject | Add-Member -MemberType NoteProperty -Name $colNames[$i] -Value $cells.item($i).innerText
            }

            $FullTable  += $rowObject
        }
    }

    return $FullTable 
}

$table = scrapeTableHTMLFromPage "http://10.0.17.40/IOC.html"
$psTable = convertHTMLTableToPSTable $table

$psTable