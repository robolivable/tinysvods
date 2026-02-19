$folder = ".\vods\"
$logFile = ".\error.log"

"" | Out-File $logFile

Get-ChildItem -Path $folder -Recurse -Include *.mp4,*.mkv,*.webm | ForEach-Object {
    $file = $_
    $output = ffprobe -v error -of default=noprint_wrappers=1 $file.FullName 2>&1
    if ($output) {
        "===>>> $($file.Name) <<<===" | Out-File $logFile -Append
        $output | Out-File $logFile -Append
    }
}
