$git    = 'C:\Program Files\Git\bin\git.exe'
$date   = Get-Date -Format 'yyyy-MM-dd'
$time   = Get-Date -Format 'HH:mm:ss'
$dir    = 'C:\Users\eaadmad\OneDrive - Ericsson\Irshad-CN\Projects\AI-Daily-Work'
$file   = "$dir\prompts-$date.md"

# Get the prompt message from the correct env variable
$message = $env:USER_PROMPT
if (-not $message) { $message = "(prompt text not captured)" }

# Save prompt to daily log file
if (!(Test-Path $file)) {
    Set-Content -Path $file -Value "# Prompts Log - $date`n"
}

Add-Content -Path $file -Value "## [$time]`n$message`n"

# Commit and push to GitHub
Set-Location $dir
& $git add "prompts-$date.md"
& $git commit -m "prompts: add entry $date $time"
& $git push origin main 2>&1
