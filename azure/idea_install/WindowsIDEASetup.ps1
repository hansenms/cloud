iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y wget
choco install -y imdisk
choco install -y git
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
choco install -y googlechrome
choco install -y wincdemu

#Import-Module ServerManager
#Add-WindowsFeature as-net-framework

