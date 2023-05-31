# Define the list of available components
$components = @(
    @{
        Name = "Qt 5.15.2 MinGW 64-bit"
        URL = "https://download.qt.io/official_releases/qt/5.15/5.15.2/qt-opensource-windows-x86_64-5.15.2.exe"
        Arguments = "-v"
    },
    @{
        Name = "Qt Creator 4.14.2"
        URL = "https://download.qt.io/official_releases/qtcreator/4.14/4.14.2/qt-creator-opensource-windows-x86_64-4.14.2.exe"
        Arguments = "-v"
    },
    @{
        Name = "Qt Documentation"
        URL = "https://download.qt.io/official_releases/qt/5.15/5.15.2/qt-opensource-windows-x86_64-5.15.2-docs.zip"
        Arguments = ""
    }
)

# Prompt the user to select which components to install
$selections = $components | Out-GridView -Title "Select components to install" -PassThru

# Download and install the selected components
foreach ($selection in $selections) {
    $filename = $selection.URL.Split("/")[-1]
    $filepath = "$PWD\$filename"
    Write-Host "Downloading $($selection.Name)..."
    Invoke-WebRequest -Uri $selection.URL -OutFile $filepath
    Write-Host "Installing $($selection.Name)..."
    Start-Process -FilePath $filepath -ArgumentList $selection.Arguments -Wait
    Write-Host "Finished installing $($selection.Name)."
}