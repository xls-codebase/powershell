
$uri = "https://jsonplaceholder.typicode.com/posts/"
$file = "index.html" 
$templateFile = "template.html"
$title = "API-Results"
$htmlFragment = ""
try {
    # $result = Invoke-RestMethod $uri -SkipHttpErrorCheck
    $result = Invoke-RestMethod $uri 
    
    if ($result.Count -gt 0) {
        $htmlFragment += "<table>"
        $propertyNames = $result[0].psobject.Properties.Name
    
        #Table Header
        $htmlFragment += "<thead><tr>"
        foreach ($propertyName in $propertyNames) {
            $htmlFragment += "<th>" + $propertyName + "</th>"
        }
        $htmlFragment += "</tr></thead>"
        
        #Table Data
        foreach ($row in $result) {
            $html = "<tr>"
        
            $row.psobject.properties | ForEach-Object Name |
                ForEach-Object { $html += "<td>" + $row.$_ + "</td>"}
        
            $html += "</tr>"
            $htmlFragment += $html
        } 
        $htmlFragment += "</table>"
    }
} catch{
    "Fehler" | Write-Host 
    $htmlFragment += "<p style=`"color:red`">An error occured: " + $_.Exception.Message + "</p>"
    $htmlFragment += "<p style=`"color:red`">uri: " + $uri + "</p>"


}

$html = Get-Content $templateFile
$html = $html -replace "###TITLE###", $title
$html = $html -replace "###CONTENT###", $htmlFragment

$html | Out-File $file