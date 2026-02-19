$files = Get-ChildItem -Recurse -Filter ".\vods\*.mkv"

foreach ($file in $files) {
    Write-Host "Fast Scanning: $($file.Name)" -ForegroundColor Yellow
    
    # Uses stream mapping and copy (no decoding)
    $err = & ffmpeg -v error -i $($file.FullName) -map 0:v:0 -c copy -f null - 2>&1
    
    if ($err) {
        Write-Host "BROKEN HEADER: $($file.Name)" -ForegroundColor Red
        $err | Out-File -FilePath "broken_headers.txt" -Append
    }
}
