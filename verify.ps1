$files = Get-ChildItem -Recurse -Filter ".\vods\*.mkv"

foreach ($file in $files) {
    Write-Host "Checking: $($file.Name)" -ForegroundColor Cyan
    
    # Run FFmpeg full decode
    # 2>&1 redirects errors so PowerShell can capture them
    $err = & ffmpeg -v error -i $($file.FullName) -f null - 2>&1
    
    if ($err) {
        $logName = "$($file.BaseName)_error_$(Get-Date -Format 'yyyyMMdd').txt"
        $err | Out-File -FilePath $logName
        Write-Host "CORRUPT: $($file.Name) - Log saved to $logName" -ForegroundColor Red
    } else {
        Write-Host "CLEAN: $($file.Name)" -ForegroundColor Green
    }
}
