[CmdletBinding()]
param(
    $QtSrcUrl = "https://download.qt.io/official_releases/qt/5.15/5.15.2/single/qt-everywhere-src-5.15.2.zip",
    $QtStaticDir = "C:\Qt\Static", # NO TRAILING SLASH
    $QtVersion = "5.15.2", #If you change this, you'll need to change the URL above to download as well...
    $MingwDir = "",
    [switch]$NoPause = $false
)

# PowerShell execution policy.
Set-StrictMode -Version 3

#-----------------------------------------------------------------------------
# Main code
#-----------------------------------------------------------------------------

function Main
{
    # Check that 7zip is installed. We use it to expand the downloaded archive.
    [void] (Get-7zip)
	
    # Get Qt source file name from URL.
    $QtSrcFileName = Split-Path -Leaf $QtSrcUrl

    # If Qt version is not specified on the command line, try to extract the value.
    if (-not $QtVersion) {
        $QtVersion = $QtSrcFileName -replace "`.[^`.]*$",''
        $QtVersion = $QtVersion -replace 'qt-',''
        $QtVersion = $QtVersion -replace 'everywhere-',''
        $QtVersion = $QtVersion -replace 'opensource-',''
        $QtVersion = $QtVersion -replace 'src-',''
        $QtVersion = $QtVersion -replace '-src',''
    }
    Write-Output "Building static Qt version $QtVersion"

    # Qt installation directory.
    $QtDir = "$QtStaticDir\$QtVersion"

    # Get MinGW root directory, if not specified on the command line.
    if (-not $MingwDir) {
        # Search all instances of gcc.exe from C:\Qt prebuilt environment.
        $GccList = @(Get-ChildItem -Path C:\Qt\Tools\mingw*\bin\gcc.exe | ForEach-Object FullName | Sort-Object)
        if ($GccList.Length -eq 0) {
            Exit-Script "MinGW environment not found, no Qt prebuilt version?"
        }
        $MingwDir = (Split-Path -Parent (Split-Path -Parent $GccList[$GccList.Length - 1]))
    }
    Write-Output "Using MinGW from $MingwDir"

    # Build the directory tree where the static version of Qt will be installed.
    Create-Directory $QtStaticDir\src
    Create-Directory $QtDir

    # Download the Qt source package if not yet done.
    Download-File $QtSrcUrl $QtStaticDir\src\$QtSrcFileName

    # Directory of expanded packages.
    $QtSrcDir = "$QtStaticDir\src\$((Get-Item $QtStaticDir\src\$QtSrcFileName).BaseName)"

    # Expand archives if not yet done
    Expand-Archive $QtStaticDir\src\$QtSrcFileName $QtStaticDir\src $QtSrcDir
}