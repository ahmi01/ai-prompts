$git    = 'C:\Program Files\Git\bin\git.exe'
$date   = Get-Date -Format 'yyyy-MM-dd'
$time   = Get-Date -Format 'HH:mm:ss'
$dir    = 'C:\Users\eaadmad\OneDrive - Ericsson\Irshad-CN\Projects\AI-Daily-Work'
$file   = "$dir\prompts-$date.md"

# Save prompt to daily log file
if (!(Test-Path $file)) {
    Set-Content -Path $file -Value "# Prompts Log - $date`n"
}

$message = $env:KIRO_HOOK_MESSAGE
Add-Content -Path $file -Value "## [$time]`n$message`n"

# Commit and push to GitHub
Set-Location $dir
& $git add "prompts-$date.md"
& $git commit -m "prompts: add entry $date $time"
& $git push origin main 2>&1
if ($LASTEXITCODE -ne 0) {
    # Try pushing to master if main doesn't exist
    & $git push --set-upstream origin master 2>&1
}
