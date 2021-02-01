# 👑 Empress
A package manager as a Windows PowerShell module.


## About
This is a simple package manager written in PowerShell.
This will download the installation script of the specific package and executes it.
Packages are named after their folder in which the installation script is.

## Issues? Found Bug?
[Create an issue](https://github.com/Neocky/Empress/issues/new/choose)

## Installation
Download the package release and put the ```\Empress``` folder inside:
```C:\Users\YOURUSERNAME\Documents\WindowsPowerShell\Modules```  
Now that you have imported the module, you can call all the functions.  
To download and install a package simply run this in a elevated PowerShell Console:  
```Get-EmpPackage [PackageName]```  
Alias: ```gemp [PackageName]```
