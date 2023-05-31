Start-Process -FilePath "C:\Users\SudarshanRamdasDamah\Downloads\qt-unified-windows-x64-4.5.2-online.exe" -ArgumentList "--script", "C:\Users\SudarshanRamdasDamah\Downloads\installscript.qs", "-v" -Wait

# function Controller {
    # $installer.autoRejectMessageBoxes()
    # $installer.installationFinished.connect({
        # $gui.clickButton($buttons.NextButton)
    # })
    # $gui.clickButton($buttons.NextButton, 3000)
    # ComponentSelectionPage
    # $gui.clickButton($buttons.NextButton, 3000)
    # $gui.clickButton($buttons.NextButton)
# }

# function ComponentSelectionPage {
    # $page = $gui.currentPageWidget()
    # $list = $page.componentListWidget()
    # $items = $list.selectedItems()
    # for ($i = 0; $i -lt $items.length; $i++) {
        # $list.deselect($items[$i])
    # }
    # $qt = $list.findItems("Qt", [Qt]::MatchContains)
    # if ($qt.length -gt 0) {
        # $qt[0].setSelected($true)
    # }
    # $qt5_15_2 = $list.findItems("5.15.2", [Qt]::MatchContains)
    # if ($qt5_15_2.length -gt 0) {
        # $qt5_15_2[0].setSelected($true)
    # }
    # $clang_64 = $list.findItems("Clang 64-bit", [Qt]::MatchContains)
    # if ($clang_64.length -gt 0) {
        # $clang_64[0].setSelected($true)
    # }
    # $tools_msvc2019 = $list.findItems("MSVC 2019 64-bit", [Qt]::MatchContains)
    # if ($tools_msvc2019.length -gt 0) {
        # $tools_msvc2019[0].setSelected($true)
    # }
    # $result = $installer.messageBox("Do you want to install the selected components?", "Installation", [System.Windows.MessageBox]::YesNo, [System.Windows.MessageBoxImage]::Question)
    # if ($result -eq [System.Windows.MessageBoxResult]::Yes) {
        # $installer.setDefaultPageVisible($installer.ComponentSelection, $false)
        # $installer.setDefaultPageVisible($installer.TargetDirectory, $true)
    # } else {
        # $installer.cancel()
    # }
# }

function Controller {
    $installer.autoRejectMessageBoxes()
    $installer.installationFinished.connect({
        $gui.clickButton($buttons.NextButton)
    })
    $gui.clickButton($buttons.NextButton, 3000)
    ComponentSelectionPage
    $gui.clickButton($buttons.NextButton, 3000)
    $gui.clickButton($buttons.NextButton)
}

function ComponentSelectionPage {
    $page = $gui.currentPageWidget()
    $list = $page.componentListWidget()
    $items = $list.selectedItems()
    for ($i = 0; $i -lt $items.length; $i++) {
        $list.deselect($items[$i])
    }
    $qt = $list.findItems("Qt", [Qt]::MatchContains)
    if ($qt.length -gt 0) {
        $qt[0].setSelected($true)
    }
    $qt5_15_2 = $list.findItems("5.15.2", [Qt]::MatchContains)
    if ($qt5_15_2.length -gt 0) {
        $qt5_15_2[0].setSelected($true)
    }
    $clang_64 = $list.findItems("Clang 64-bit", [Qt]::MatchContains)
    if ($clang_64.length -gt 0) {
        $clang_64[0].setSelected($true)
    }
    $tools_msvc2019 = $list.findItems("MSVC 2019 64-bit", [Qt]::MatchContains)
    if ($tools_msvc2019.length -gt 0) {
        $tools_msvc2019[0].setSelected($true)
    }
    $installer.setDefaultPageVisible($installer.ComponentSelection, $false)
    $installer.setDefaultPageVisible($installer.TargetDirectory, $true)
}

Controller