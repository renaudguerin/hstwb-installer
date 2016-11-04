# HstWB Installer

## Description

HstWB Installer is a set of scripts to make it easy to build an Amiga HDF image with preinstalled Workbench, WHDLoad games and/or demos incl. Arcade Game Selector 2 or iGame menu to launch games and/or demos. 

Since Amiga Workbench and Kickstart roms are licensed property these files can't be included as they need to be acquired legally by buying Cloanto Amiga Forever or using grabkick from aminet to dump roms from real Amiga's.

Setting up a blank Amiga HDF image with e.g. PFS3, Workbench, Kickstarts roms and WHDLoad games/demos installed properly can be a cumbersome task unless you spend a lot of time figuring out how this is done step by step.

This is where HstWB Installer come to aid and can help to automate such installations and should be possible for almost anyone to do with very little knowledge about Amiga. 

*HstWB is short for my name and Workbench (very original, I know).* 

## User interface

Currently the plan is to make the following user interfaces for HstWB-Installer:

* Powershell: Windows powershell script launched from console or Windows Explorer via cmd script.
* Bash: Mac/Linux script launched from terminal.

Powershell script can be extended to use WinForms to present a Windows application, which makes it much more user friendly, but this has low priority. First priority is to make a powershell script, that can perform an automated installation of packages to an Amiga HDF image. 

Something similar could be used for Mac/Linux, but I'm not aware of whats possible there. 

Using Mac/Linux would also require use of FS-UAE emulator.

## Images

Following Amiga HDF images are included:

* 8GB: An 8GB image with 2 partitions: DH0 500MB bootable as System:, DH1 7000MB as Work:. Both partitions are formatted with PFS3 AIO by Toni Wilen.

More images can manually be added to images directory compressed with zip. 

## Packages

Following packages are included and they can be selected during configuration, which will be installed automatically:

* Workbench: Workbench identified by MD5 hash from defined workbench adf directory. Files from adf's are extracted using unadf and copied to DH0:.
* Kickstart: Kickstart roms identified by MD5 hash from defined kickstart rom directory. Files are copied to DH0:Devs/Kickstarts, required for WHDLoad.
* HstWB System: Workbench configuration built by me. This is an extension of BetterWB with few files borrowed from ClassicWB.
* HstWB AGS2 EAB WHDLoad Games v2.6: Arcade Game Selector 2 menu generated for WHDLoad games. This contains screenshots and details like name, publisher, Genre an year for each game. 
* HstWB AGS2 EAB WHDLoad Demos v2.6: Arcade Game Selector 2 menu generated for WHDLoad demos. This contains screenshots and details like name, group and party and year for each demo. 
* HstWB iGame EAB WHDLoad Games v2.6: iGame gameslist and screenshots generated for WHDLoad games. This gameslist has names without stars, spaces and wierd characters to have a clean game list in iGame.
* HstWB iGame EAB WHDLoad Demos v2.6: iGame gameslist and screenshots generated for WHDLoad demos. This gameslist has names without stars, spaces and wierd characters to have a clean game list in iGame.
* EAB WHDLoad Games v2.6: WHDLoad games pack from EAB with update 2.6 applied.
* EAB WHDLoad Demos v2.6: WHDLoad demos pack from EAB with update 2.6 applied.

Versions are used to allow having future and updated versions of packages.

**EAB WHDLoad Games and EAB WHDLoad Demos will be provided by another script, which automatically download packs and updates from EAB ftp server, unzip, combines, packs and copies them to packages directory**

## Package files and their structure

A package is zip file located in the packages directory. Packages are identified by the following naming convention:

[name].[version].zip

As a bare minimum a package must contain the following files:

- install: AmigaOS script to perform installation is the package.
- package.ini: Ini file describing the content of the package including name, description, version.

Any other files can be part of a package as resources to install.

Here's an example of package content:

HstWB_System.1.0.0.zip:
- install: AmigaOS script to extract system.lha.
- system.lha: Lha archive with system files to install.

Packages are kept simple, so they are easy to build and maintain.

## Installation

The installation is done through WinUAE. To enable installing Workbench automatically following scripted process is used:

* Use predefined A1200 WinUAE configuration.
* Identified A1200 kickstart rom is used.
* Selected Amiga HDF image is mounted as harddisk file non-bootable.
* Install directory mounted as bootable harddisk. This contains a startup sequence to automate installation of identified workbench adf and kickstart rom files, which are copied to this directory with installation scripts and tools.
* Identified Workbench 3.1 Workbench disk is used.
* Workbench 3.1 Workbench disk is patched to make it non-bootable. This is done by patching adf file offset 12 to 0, which make boot sector invalid and WinUAE skip booting the floppy. 
* Patched Workbench 3.1 Workbench disk is mounted as DF0:.
* The mounted non-bootable Workbench disk allows basic commands to be loaded resident for the installation process initiated by startup sequence in mounted install directory.
* WinUAE is launched and startup sequence executes installation scripts and automatically shuts down, when it's done.

The preinstalled Amiga HDF image is now ready to use in an emulator.

## Screenshots

![HstWB Installer running automated installation of Workbench](https://raw.githubusercontent.com/henrikstengaard/hstwb-installer/master/screenshots/hst-wb_installer_running1.png)
![HstWB Installer running automated installation of Kickstart roms](https://raw.githubusercontent.com/henrikstengaard/hstwb-installer/master/screenshots/hst-wb_installer_running2.png)
![Preinstalled image booted in WinUAE showing Workbench](https://raw.githubusercontent.com/henrikstengaard/hstwb-installer/master/screenshots/preinstalled_workbench.png)