# sblaunch - Alternative launcher for Scarlet Blade Vendetta, intended to make the game launchable on WINE/Proton. 

# Installation and usage:
Note: The version of XignCode that ships with Scarlet Blade Vendetta is not compatible with WINE/Proton, and requires a shim which can be downloaded here (and all source code is available):
https://github.com/nazgulsenpai/sbxigncode/releases/tag/v0.1
In the xigncode folder of your Scarlet Blade Vendetta installation, backup the replace the existing x3.xem with this one. Every time you install a patch the official launcher, you will need to repeat this step as the official launcher will replace it with the original version.

Note: This launcher does not patch the game. You will need to run the official launcher to install patches when they're released, and if using through WINE/Proton, reinstall the x3.xem shim. 

Download the latest release and extract to your Scarlet Blade Vendetta folder, the same folder with SBLauncher.exe and SB.exe. 

To use, simply run `sblaunch.exe [username] [password]` or populate the username= password= sections in sblaunch.ini. 

Example using vanilla wine: `wine sblaunch.exe user pass`

Example in Lutris: Install Scarlet Blade Vendetta through any method and replace the SBLauncher.exe with sblaunch.exe and in the Arguments field `username password` (or populate sblaunch.ini as above)

![Screenshot](https://github.com/nazgulsenpai/sblaunch/blob/master/images/lutris.jpg)

# Building:
This launcher is written in Nim and intended to be compiled as a Windows exe that can be launched directly by WINE/Proton, login and launch SB.exe.

To build on Linux for Windows, you will need to install the mingw compiler toolchain for your distribution. The method can vary, but on my Void Linux system the package is `cross-x86_64-w64-mingw32-crt`

`nim c -d:mingw -d:release sblaunch.nim` 

As far as I can tell, the XignCode shim x3.xem must be built in Visual Studio, possibly Visual Studio 2015. I was able to get it to build with mingw on Linux but SBV simply would not load it (Gameguard Error 00000007E) and I'm not sure why. The binary works, and the source code is available if you're concerned about running an unknown binary on your system.

