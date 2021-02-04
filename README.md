# 👑 Empress
A simple package manager written as a Windows PowerShell module.

## About
This is a simple package manager written in PowerShell.  
If run, it will download an unattended installation script of the specific program and executes the PowerShell script.  
The PowerShell script will then download and silently install the specific program.   
Packages are named after their folder in which their installation script is.  
All available software packages are in the [SortwarePackages](https://github.com/Neocky/Empress/tree/main/SoftwarePackages) Folder.

## Issues? Found a bug?
[Create an issue](https://github.com/Neocky/Empress/issues/new/choose)

## Installation
1. Download the module. You can find all releases [here](https://github.com/Neocky/Empress/releases).  
2. Extract the zip file  
3. Unblock the file with PowerShell: ```Unblock-File -Path C:\Users\YOURUSERNAME\Documents\Downloads\Empress\*```
3. Put the ```\Empress``` folder inside:  ```C:\Users\YOURUSERNAME\Documents\WindowsPowerShell\Modules```  

Now that you have imported the module, you can call the Empress functions.  
  
  
## How to
To download and install a package simply run this command in a elevated PowerShell Console:  
```Get-EmpPackage [PackageName]```  
An alias exists too: ```gemp [PackageName]```  
#### For example:  
```Get-EmpPackage firefox```  
or as alias:  
```gemp firefox```  
**Thats it!**  
*Now it will download the installation script and executes it which will then download the program and install it silently.*  
You can find all available packagaes in the [SoftwarePackages](https://github.com/Neocky/Empress/tree/main/SoftwarePackages) folder.
