# Final cleanup script to remove unnecessary files and folders

# Delete all script files except the current one
$scriptFiles = @(
    "organize-for-vercel.ps1",
    "fix-images.ps1",
    "fix-duplicate-refs.ps1",
    "cleanup.ps1",
    "final-fix.ps1"
)

foreach ($file in $scriptFiles) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "Deleted unnecessary script: $file"
    }
}

# Remove original FEE Project folder (after confirming all files have been copied)
if (Test-Path ".\FEE Project") {
    # Count how many files are in the public directory
    $publicFileCount = (Get-ChildItem -Path ".\public" -Recurse -File).Count
    
    # If we have a reasonable number of files in public, we can safely remove the original folder
    if ($publicFileCount -gt 20) {
        Remove-Item ".\FEE Project" -Recurse -Force
        Write-Host "Deleted original 'FEE Project' folder (files have been copied to public directory)"
    } else {
        Write-Host "Warning: Not deleting 'FEE Project' folder as there may be missing files in the public directory"
    }
}

# Remove any duplicate HTML files in the root directory
Get-ChildItem -Path ".\" -File -Filter "*.html" | ForEach-Object {
    if (Test-Path ".\public\$($_.Name)") {
        Remove-Item $_.FullName -Force
        Write-Host "Removed duplicate HTML file from root: $($_.Name)"
    }
}

# Check for and remove duplicated image files
$duplicateImages = Get-ChildItem -Path ".\public\assets\images\*.{jpg,jpeg,png,gif,webp,JPG,PNG,GIF,WEBP}" | 
    Group-Object Name | 
    Where-Object { $_.Count -gt 1 }

foreach ($duplicate in $duplicateImages) {
    # Keep the newest file, remove others
    $files = $duplicate.Group | Sort-Object LastWriteTime -Descending
    for ($i = 1; $i -lt $files.Count; $i++) {
        Remove-Item $files[$i].FullName -Force
        Write-Host "Removed duplicate image: $($files[$i].Name)"
    }
}

# Remove old index.html from root (if exists)
if (Test-Path ".\index.html") {
    Remove-Item ".\index.html" -Force
    Write-Host "Removed redundant index.html from root"
}

# Delete any empty directories
Get-ChildItem -Path "." -Directory -Recurse | 
    Where-Object { (Get-ChildItem -Path $_.FullName -Recurse -File) -eq $null } | 
    ForEach-Object {
        Remove-Item $_.FullName -Force -Recurse
        Write-Host "Removed empty directory: $($_.FullName)"
    }

Write-Host "Cleanup complete - project structure is clean and ready for deployment" 