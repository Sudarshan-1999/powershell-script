function Get-7zip
{
    $Exe = "C:\Program Files\7-Zip\7z.exe"
    if (-not (Test-Path $Exe)) {
        $Exe = "C:\Program Files (x86)\7-Zip\7z.exe"
    }
    if (-not (Test-Path $Exe)) {
        Exit-Script "7-zip not found, install it first, see http://www.7-zip.org/"
    }
    $Exe
}
Get-7zip