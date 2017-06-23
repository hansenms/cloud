Installation of IDEA on Azure
------------------------------

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhansenms%2Fcloud%2Fmaster%2Fazure%2Fidea_install%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fhansenms%2Fcloud%2Fmaster%2Fazure%2Fidea_install%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This deployment sets up a Windows VM and a Linux VM ready for installing Siemens IDEA sequence and reconstruction development. After deployment is complete, the Windows VM will still need the following installed:

* Install Visual Studio 2008 to C:\MSVS2008.
* Install Windows SDK from http://www.microsoft.com/download/en/details.aspx?id=11310. Use install path C:\WinSDK\Windows\v6.1.
* The IDEA installation from the iso image

WinCDEmu is install, which should allow you to mount iso files with Visual Studio and the IDEA environment. 

The Windows VM also has Chrome, git, and other useful tools installed. [Chocolatey](https://chocolatey.org) is also installed and can be used to add more packages. 
  

Connecting the Windows and MARS machines
----------------------------------------

On the Windows IDEA machine, generate a ssh keypair using `ssh-keygen` and copy the `id_rsa.pub` file to the MARS Linux machine. Log into the MARS (`ssh <USERNAME>@mars` or whatever the local IP address is), then use the copied keyfile to setup passwordless login from the IDEA Windows host to the MARS:

```
cat id_rsa.pub >> .ssh/authorized_keys
```
Then switch to the root account and copy the same file:

```
sudo su - root
cp ~<USERNAME>/.ssh/authorized_keys .ssh/
```

On the Windows IDEA host. Edit the file `C:\MIDEA\bin\syngo.MR.MrIDEA.IDEA.exe.config`. Find the section with the `VBoxIP` and set it to the internal address of the MARS box:

```
    <VBoxIP Value="mars"/>
    <SSHCommand Command="ssh -l root -o StrictHostKeyChecking=no %VBOX_IDEA_IP%"/>
```

Then edit the script `C:\MIDEA\bin\vboxctrl` to contain something like this (it should essentially do nothing and return 0):

```
@ECHO OFF
ECHO      ----------------------------------------------------------------------
ECHO          !!!! VBOXCTRL disabled, please start/stop machine manually !!!!    
ECHO      ----------------------------------------------------------------------
EXIT 0
```

Validate that it is possible to access the MARS from the Windows IDEA host with the command `ideassh` and validate that it is possible to compile targets (both Windows and Linux).

