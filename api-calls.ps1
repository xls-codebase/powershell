
$uri = "https://jsonplaceholder.typicode.com/posts/"
$file = "index.html" 

# Parameters for the HTML-File (like Pagetitle, ...)
$htmlParams = @{
    Title = "API-Data"
    Charset = "UTF-8"
}

$result = Invoke-RestMethod $uri -SkipHttpErrorCheck
$result | ConvertTo-Html @htmlParams | Out-File $file