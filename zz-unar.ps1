# Usage:
# PowerShell.exe -File .\zz-unar.ps1 [-j] -f <path>
# -j means 'unar -e shift_jis'
param([switch]$j, [string]$f="")
$ver="1.0"

$unar_path="$env:LocalAppData\unar\unar.exe"
Set-Alias unar $unar_path
$suffix_pattern="^\.(zi.*|7z|rar)"

if (-not (Test-Path -Path $unar_path -PathType Leaf)) {
    Write-Host "Unar is not installed.`nDownload from theunarchiver.com."
    $unar_uri="https://cdn.theunarchiver.com/downloads/unarWindows.zip"
    $unar_tmp="$env:Temp\unarWindows.zip"
    Invoke-WebRequest -Uri $unar_uri -OutFile $unar_tmp
    Expand-Archive -LiteralPath $unar_tmp -DestinationPath "$env:LocalAppData\unar"
    Write-Host "Unar is installed to '$env:LocalAppData\unar'"
    Remove-Item $unar_tmp
}

$f_is_file=$false
if ($f) {
    Write-Host $f
    if ( (Test-Path -Path $f -PathType Leaf) -and ((Get-Item $f).Extension -match $suffix_pattern) ) {
        $f_is_file=$true
    }
    else {
        Write-Host "Not a valid file, or path contains invalid symbols. Exit." -Foregroundcolor Red
        pause; exit
    }
}
else {
    Write-Host "No inputs. Exit." -Foregroundcolor Red
    pause; exit
}

if ($f_is_file) {
    $output_path=(Get-Item $f).DirectoryName
    if ($j) {
        unar -e shift_jis -o $output_path $f
    }
    else {
        unar -o $output_path $f
    }
}
pause; exit
