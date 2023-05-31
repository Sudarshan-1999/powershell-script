function RCC
{
    $rcc = 'D:\rcc'
    $branch_name =  'develop'
    Write-Output $rcc
    
    Set-Location $rcc
    .\AppFx\Scripts\Setup_Repo.bat $branch_name
    
}

function FCC
{
    $fcc = 'C:\Users\SudarshanRamdasDamah\OneDrive - Ramp Group Technologies\Documents\win\fcc'
    $branch_name = 'develop'
    Write-Output $fcc
    Set-Location $fcc
    .\AppFx\Scripts\Setup_Repo.bat $branch_name
}

function HMIC_SANDBOX
{
    $hmic_sandbox = 'D:\Downloads\hmicsandbox'
    $branch_name = 'develop'
    Write-Output $hmic_sandbox
    Set-Location $hmic_sandbox
    .\AppFx\Scripts\Setup_Repo.bat $branch_name
    # Set-Location D:\dtest
}

# function HMI_CLUSTER
# {
#     $hmic_sandbox = 'D:\Downloads\hmicluster'
#     $branch_name = 'develop'
#     Write-Output $hmic_sandbox
#     Set-Location $hmic_sandbox
#     .\AppFx\Scripts\Setup_Repo.bat $branch_name
#     Set-Location D:\dtest
# }


. RCC
. FCC
. HMIC_SANDBOX
# . HMI_CLUSTER





