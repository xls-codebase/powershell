
$uri = "https://jsonplaceholder.typicode.com/posts/"
$file = "index.html" 
$templateFile = "template.html"
$title = "API-Results"

$result = Invoke-RestMethod $uri -SkipHttpErrorCheck
$table = $result | ConvertTo-Html -Fragment

$html = Get-Content $templateFile

$html = $html -replace "###TITLE###", $title
$html = $html -replace "###CONTENT###", $table

$html | Out-File $file

