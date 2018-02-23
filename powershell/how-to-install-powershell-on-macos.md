# How to install PowerShell core on MacOS

## Inital Installation
Do the following from the macOS console:

Install [Homebrew](http://brew.sh/). If you dont already have it, run this:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Install [Homebrew-Cask](https://caskroom.github.io/) so future installations of software via brew is much nicer. 
```bash
brew tap caskroom/cask
```
Now you can install PowerShell by running:
```
brew cask install powershell
```
You can be sure it is working by running:
```
pwsh
```
This should give you the powershell prompt and away you go!

## How to upgrade
Run the following from the console:
```
brew update
brew cask upgrade powershell
```
That should do it.

## How to re-install
If for whatever reason you want to reinstall PowerShell use:
```
brew cask reinstall powershell
```

## How to remove
If you are nuts and want to remove PowerShell from macOS run:
```
brew cask uninstall powershell
```
