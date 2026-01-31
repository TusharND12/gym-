# GitHub Pages Enabler Script
# This script enables GitHub Pages via GitHub API

$repo = "TusharND12/gym-"
$token = $env:GITHUB_TOKEN

if (-not $token) {
    Write-Host "GitHub token not found. Trying alternative method..."
    Write-Host "Please set GITHUB_TOKEN environment variable or the script will use public API"
}

$headers = @{
    "Accept" = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

if ($token) {
    $headers["Authorization"] = "Bearer $token"
}

# Enable GitHub Pages
$body = @{
    source = @{
        branch = "main"
        path = "/"
    }
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "https://api.github.com/repos/$repo/pages" `
        -Method POST `
        -Headers $headers `
        -Body $body `
        -ContentType "application/json"
    
    Write-Host "GitHub Pages enabled successfully!"
    Write-Host "Your site will be available at: https://tusharnd12.github.io/gym-/"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
    Write-Host "Note: You may need to enable GitHub Pages manually in repository settings."
    Write-Host "Go to: https://github.com/$repo/settings/pages"
    Write-Host "Select 'GitHub Actions' as source and save."
}
