function Disable-InternetExplorerESC {

    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"

    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"

    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force

    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force

    Stop-Process -Name Explorer -Force

    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green

}


function Enable-InternetExplorerESC {

    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"

    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"

    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 1 -Force

    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 1 -Force

    Stop-Process -Name Explorer

    Write-Host "IE Enhanced Security Configuration (ESC) has been enabled." -ForegroundColor Green

}


function Disable-UserAccessControl {

    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000 -Force

    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green    

}


Disable-UserAccessControl

Disable-InternetExplorerESC

Import-Module ServerManager
Add-WindowsFeature as-net-framework

Import-Module BitsTransfer
Start-BitsTransfer -source "https://ideainstallation.blob.core.windows.net/install/vstudio2008.iso"

$env:chocolateyUseWindowsCompression = 'true'
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
cinst -y imdisk
imdisk a -f .\vstudio2008.iso -m "f:"


#$driveletter\Setup\setup.exe /?



