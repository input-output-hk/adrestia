# Windows

  - [How to run Windows](#how-to-run-windows)
      - [Setting up a Windows 10
        VirtualBox](#setting-up-a-windows-10-virtualbox)
      - [Using GitHub pipelines](#using-github-pipelines)
      - [Renting a Windows VM in the
        cloud](#renting-a-windows-vm-in-the-cloud)
  - [Building for Windows](#building-for-windows)
      - [cross-compiling for windows](#cross-compiling-for-windows)
      - [phyx ghc packages on choco](#phyx-ghc-packages-on-choco)
  - [Windows/Haskell Issues](#windowshaskell-issues)
      - [terminating processes](#terminating-processes)
      - [path separators](#path-separators)
      - [forbidden filenames](#forbidden-filenames)
      - [temp directories](#temp-directories)
      - [file locking (exclusive
        access)](#file-locking-exclusive-access)
      - [io with the ghc rts
        (i.e. deadlocks)](#io-with-the-ghc-rts-i.e.-deadlocks)
      - [filesystem mtime resolution](#filesystem-mtime-resolution)
  - [Misc](#misc)
  - [Questions](#questions)

Most Daedalus users are on Windows.

## How to run Windows

These are some options for running your code on Windows without having
to boot your system into Windows.

### Setting up a Windows 10 VirtualBox

See the PowerShell script [`iohk-setup.ps1`](../scripts/iohk-setup.ps1)
for a semi-automated way of getting a development and testing
environment for Windows 10.

### Using GitHub pipelines

GitHub (a division of Microsoft) allow you to run CI actions on Windows
for free.

Use [`runs-on: windows-latest`](https://help.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idruns-on)
in the pipeline file.

### Renting a Windows VM in the cloud

Amazon Web Services have [Windows AMIs](https://aws.amazon.com/windows/resources/amis/)
that you can spin up. Windows Server 2016 is similar to Windows 10
([Wikipedia](https://en.wikipedia.org/wiki/Windows_Server_2016)).

Ask devops for AWS credentials for the IOHK development account.

Setting up RDP and the initial password is a bit of a pain.

## Building for Windows

### cross-compiling for windows

### phyx ghc packages on choco

## Windows/Haskell Issues

TODO: Document the issues that we commonly encounter when developing
Haskell code for windows.

### terminating processes

### path separators

### forbidden filenames

### temp directories

### file locking (exclusive access)

### io with the ghc rts (i.e. deadlocks)

### filesystem mtime resolution

## Misc

  - [Colemak layout for Microsoft Windows](https://colemak.com/Windows)

  - [WindowsSpyBlocker](https://github.com/crazy-max/WindowsSpyBlocker)
    - install these firewall rules to prevent windows update downloads
    and other tracking.

## Questions

  - How to set up a SSH server on Windows 10 with Powershell?

  - How to set up a WSL installation with a Powershell script?

  - Does [[Nix]] work under WSL? WSL2?
