############################################################################
#
# Windows dev environment for Adrestia
#
# https://input-output-hk.github.io/adrestia/resources/Windows
#
# After running this script you will have a VirtualBox machine which
# is be able to compile cardano-wallet for Windows using stack.
#
# It will also be able to run the tests for cardano-wallet and
# cardano-launcher.
#
############################################################################
#
#
# Initial VM Setup
# ----------------
#
# Set up windows 10 in VirtualBox.
#
#     - Download the ISO from Microsoft, and install into a new VM
#       https://www.microsoft.com/en-au/software-download/windows10ISO
#       To be safe, just get the US English version.
#     - In the VM disks settings, add a SATA disk which will be E:
#     - In the VM disks settings, add the installer ISO to the CD drive.
#     - Share the directory containing this script as win_shared
#     - Power on the VM and install windows
#     - Enter your product key into Windows
#       (if you don't have one yet, it doesn't need to be done immediately)
#     - Install VirtualBox guest additions,
#     - Use the disk management tool to quick-format E:
#     - Use linked clones in virtualbox so that you can snapshot and
#       revert to working configs.
#
# For the Chocolatey package installs to work, you will need to
# temporarily switch off any Microsoft-blocking software that you have
# enabled (e.g. [WindowsSpyBlocker](https://github.com/crazy-max/WindowsSpyBlocker/tree/master/data/openwrt/spy)).
#
#
# Getting a Windows product key
# -----------------------------
#
# The VM will work for a little while without a product key.
#
# But if you have an OEM license for Windows on your computer, which
# you aren't otherwise using because Linux is installed, you can find
# it with:
#
#     sudo strings /sys/firmware/acpi/tables/MSDM
#
# Enter this key in Control Panel, "Activation settings" and "Change product key".
#
#
# Installation
# ------------
#
# 1. Click Start
# 2. Type Powershell, but don't press enter
# 3. Right-click on the Powershell item, then
#    right-click and choose "Run as administrator"
# 4. Run `Get-ExecutionPolicy` in the shell
#    If it returns Restricted, then run `Set-ExecutionPolicy Bypass -Scope Process`.
# 5. `cd \\VBOXSRV\win_shared`
# 6 `.\iohk-setup.ps1`
# 7. Go back to step 1 and run the steps a second time.
# 8. You should now be in directory to E:\cardano-wallet ($env:WALLET_DIR).
#
# Note that the cardano-wallet clone is shallow.
# If you need to change branch, then do
#   git fetch --unshallow
#
############################################################################

# from here onwards, errors terminate the script
$ErrorActionPreference = "Stop"
Set-ExecutionPolicy Bypass -Scope Process -Force
$drive = "E:"
$downloads = "$drive\Downloads"

# Set-PSDebug -Trace 1

$env:chocoPath = "$drive\chocolatey"
$env:ChocolateyToolsLocation = "$drive\tools"

if (!(Get-Command choco.exe -ErrorAction SilentlyContinue)) {
  Write-Output "Installing choco to $env:chocoPath"

  [System.Environment]::SetEnvironmentVariable("chocoPath", "$env:chocoPath", "Machine")
  [System.Environment]::SetEnvironmentVariable("ChocolateyToolsLocation", "$env:ChocolateyToolsLocation", "Machine")

  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

  refreshenv

  Write-Output "Chocolately installed. Now close this powershell and start again."
  Write-Output "Remember to run PS as administrator and the Set-ExecutionPolicy thing"
  exit
}

choco install -y 7zip.install
choco install -y curl
choco install -y vcredist140
choco install -y vcredist2013
choco install -y git.install
choco install -y vim
choco install -y msys2

# Phyx installers
choco install -y ghc --version=8.6.5
choco install -y cabal

# NPM and stuff
choco install -y nodejs

refreshenv

############################################################################
# Install WSL

Enable-WindowsOptionalFeature -NoRestart -Online -FeatureName Microsoft-Windows-Subsystem-Linux

# Unfortunately, it's not possible to install windows app store apps
# (e.g. Ubuntu image for WSL) using powershell.


############################################################################
# Setup download directory

New-Item -ItemType Directory -Force -Path "$downloads"


############################################################################
# Install colemak layout for Rodney's keyboard

if (Test-Path "$downloads\colemak.zip") {
  Write-Output "colemak already downloaded"
} else {
  curl.exe -L https://colemak.com/pub/windows/Colemak-1.1-Caps-Lock-Unchanged.zip -o "$downloads\colemak.zip"
}
7z x "$downloads\colemak.zip" "-o$downloads\colemak" -aos
iex "$downloads\colemak\Colemak2_amd64.msi /quiet /norestart"


############################################################################
# OpenSSL, xz, libsodium

if (Test-Path "$downloads\Win64OpenSSL.exe") {
  Write-Output "openssl already downloaded"
} else {
  (New-Object Net.WebClient).DownloadFile('https://slproweb.com/download/Win64OpenSSL-1_0_2u.exe', "$downloads\Win64OpenSSL.exe")
}
cmd /c start /wait "$downloads\Win64OpenSSL.exe" /silent /verysilent /sp- /suppressmsgboxes /DIR=$drive\OpenSSL-Win64-v102

# Install liblzma/xz
if (Test-Path "$downloads\xz-windows.zip") {
  Write-Output "xz already downloaded"
} else {
  curl.exe -L https://tukaani.org/xz/xz-5.2.5-windows.zip -o "$downloads\xz-windows.zip"
}
7z x "$downloads\xz-windows.zip" "-o$drive\xz" -aos


# Install libsodium stable binary release for mingw32.
# Note that this is *not* the IOHK fork.
if (Test-Path "$downloads\libsodium-mingw.tar.gz") {
  Write-Output "libsodium already downloaded"
} else {
  curl.exe -L https://download.libsodium.org/libsodium/releases/libsodium-1.0.18-stable-mingw.tar.gz -o "$downloads\libsodium-mingw.tar.gz"
}
7z x -aoa "$downloads\libsodium-mingw.tar.gz" "-o$drive\libsodium"
7z x -aoa "$drive\libsodium\libsodium-mingw.tar" "-o$drive\libsodium"

$libsodiumpc = @"
prefix=$drive/libsodium/libsodium-win64
exec_prefix=$drive/libsodium/libsodium-win64
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: libsodium
Version: 1.0.18
Description: A modern and easy-to-use crypto library

Libs: -L${libdir} -lsodium
Libs.private:  -pthread
Cflags: -I${includedir}
"@
$libsodiumpc | Out-File -FilePath "$drive\tools\msys64\usr\lib\pkgconfig\libsodium.pc" -Encoding ASCII

############################################################################
# Install pkg-config in msys2 environment which is used by stack

msys2 pacman -Sy --noconfirm pkg-config

############################################################################
# Install and configure stack

if (Test-Path "$downloads\stack.zip") {
  Write-Output "stack is already download"
} else {
  curl.exe -L http://www.stackage.org/stack/windows-x86_64 -o "$downloads\stack.zip"
}
7z x "$downloads\stack.zip" "-o$drive\stack" -aos

# Avoid long paths on Windows
$env:STACK_ROOT = "$drive\s"
$env:STACK_WORK = ".w"
$env:WORK_DIR = "$drive\w"
# Override the temp directory to avoid sed escaping issues
# See https://github.com/haskell/cabal/issues/5386
$env:TMP = "$drive\tmp"

$env:PATH = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";$drive\stack;$Env:Programfiles\7-Zip;$Env:Programfiles\Git\cmd;$Env:Programfiles\chocolatey\bin;$drive\libsodium\libsodium-win64\bin;$env:WORK_DIR"

[System.Environment]::SetEnvironmentVariable("STACK_ROOT", "$env:STACK_ROOT", "Machine")
[System.Environment]::SetEnvironmentVariable("STACK_WORK", "$env:STACK_WORK", "Machine")
[System.Environment]::SetEnvironmentVariable("WORK_DIR", "$env:WORK_DIR", "Machine")
[System.Environment]::SetEnvironmentVariable("TMP", "$env:TMP", "Machine")
[System.Environment]::SetEnvironmentVariable("STACK_ROOT", "$env:STACK_ROOT", "Machine")
[System.Environment]::SetEnvironmentVariable("PATH", "$env:PATH", "Machine")

New-Item -ItemType Directory -Force -Path $env:STACK_ROOT
New-Item -ItemType Directory -Force -Path $env:TMP

# workaround for something
$stackConfigGhc = @"
ghc-options:
  "`$everything": "-copy-libs-when-linking"
"@

$stackConfig = @"
system-ghc: true
skip-msys: true
local-programs-path: "$drive\\s\\programs"
local-bin-path: "$drive\\s\\bin"
extra-include-dirs:
 - "$drive\\OpenSSL-Win64-v102\\include"
 - "$drive\\xz\\include"
 - "$drive\\libsodium\\libsodium-win64\\include"
 - "$drive\\w\\rocksdb\\include"
extra-lib-dirs:
 - "$drive\\OpenSSL-Win64-v102"
 - "$drive\\libsodium\\libsodium-win64\\lib"
 - "$drive\\xz\\bin_x86-64"
 - "$drive\\w"
$stackConfigGhc
"@
$stackConfig | Out-File -FilePath "$env:STACK_ROOT\config.yaml" -Encoding ASCII

############################################################################
# git clone

$env:WALLET_DIR = "$drive\cardano-wallet"

if (Test-Path "$env:WALLET_DIR") {
  Write-Output "cardano-wallet is already cloned"
} else {
  Write-Output "Cloning cardano-wallet to $env:WALLET_DIR"
  git.exe clone https://github.com/input-output-hk/cardano-wallet.git --depth 1 "$env:WALLET_DIR"
}

cd "$drive\"
git.exe clone https://github.com/input-output-hk/cardano-haskell.git
git.exe clone https://github.com/input-output-hk/adrestia.git
git.exe clone https://github.com/input-output-hk/cardano-launcher.git

cd "$drive\cardano-haskell"
git.exe submodule update --init --depth 1

cd "$env:WALLET_DIR"

############################################################################
# Stack setup

stack.exe path
stack.exe exec -- ghc-pkg recache
stack.exe --verbosity warn setup --no-reinstall


############################################################################
# Finished

Write-Output "Almost ready to go! A reboot is probably necessary though."
Restart-Computer -Confirm
Write-Output "Change directory to $env:WALLET_DIR and run 'stack build'"
