# Final touches before deployment

# Re-create the assets directory if it doesn't exist
if (-not (Test-Path ".\public\assets")) {
    New-Item -ItemType Directory -Force -Path ".\public\assets" | Out-Null
    Write-Host "Re-created the assets directory"
}

# Verify the images directory exists
if (-not (Test-Path ".\public\assets\images")) {
    New-Item -ItemType Directory -Force -Path ".\public\assets\images" | Out-Null
    Write-Host "Re-created the images directory"
}

# Ensure all HTML files point to the correct image and CSS paths
Get-ChildItem -Path ".\public\*.html" | ForEach-Object {
    $filePath = $_.FullName
    $content = Get-Content $filePath -Raw
    
    # Ensure all image paths are correct
    $content = $content -replace 'src="([^"h][^"t][^"t][^"p].+\.(jpg|jpeg|png|gif|webp|JPG|PNG|GIF|WEBP))"', 'src="assets/images/$1"'
    
    # Fix any broken paths
    $content = $content -replace 'src="assets/images/assets/images/', 'src="assets/images/'
    
    # Fix external image URLs
    $content = $content -replace 'src="assets/images/http', 'src="http'
    
    # Ensure all CSS files are referenced correctly
    $content = $content -replace '<link rel="stylesheet" href="([^"]+\.css)">', '<link rel="stylesheet" href="css/$1">'
    $content = $content -replace 'href="css/css/', 'href="css/'
    
    # Save the updated content
    Set-Content -Path $filePath -Value $content
}

Write-Host "Project is now clean and ready for deployment"

# Print summary of the project structure
Write-Host "`nProject Structure Summary:"
Write-Host "------------------------"
$htmlCount = (Get-ChildItem -Path ".\public\*.html" | Measure-Object).Count
$cssCount = (Get-ChildItem -Path ".\public\css\*.css" | Measure-Object).Count
$jsCount = (Get-ChildItem -Path ".\public\js\*.js" | Measure-Object).Count
$imageCount = (Get-ChildItem -Path ".\public\assets\images\*" | Measure-Object).Count

Write-Host "HTML files: $htmlCount"
Write-Host "CSS files: $cssCount"
Write-Host "JavaScript files: $jsCount"
Write-Host "Image files: $imageCount"
Write-Host "------------------------"
Write-Host "Total files: $($htmlCount + $cssCount + $jsCount + $imageCount)"

Write-Host "`nTo deploy your site to Vercel, run:"
Write-Host "1. npm install -g vercel"
Write-Host "2. vercel login"
Write-Host "3. vercel" 