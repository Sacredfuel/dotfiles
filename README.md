# Sacredfuel's dotfiles

A collection of dotfiles for various configurations, including their installation process.

## Powershell - Windows

### Windows Terminal

#### Installation

If you aren't using the Windows Terminal, what are you doing! 
Powershell is great and all, but it's lacking a lot of features from the windows terminal,
let's set that up real quick.

From PowerShell:
```powershell
winget install Microsoft.WindowsTerminal
```

Note: You must have your execution policy set to unrestricted (or at least in bypass) 
for this to work: `Set-ExecutionPolicy RemoteSigned`.

To update later on, just run that command again.

#### NerdFont

Well to start off, our font is pretty bad, so let's set up a font that is more 
visually appealing(I'd suggest the CascadiaCode Nerd Font). It will also contains 
some characters we'll need later.

To start with you can pick a nerd font from 
[here](#https://github.com/ryanoasis/nerd-fonts/releases)

Once you pick a font, download it as a zip, select all the files, right click and hit install. 
This will add the font as avalible everywhere on your Computer.

After it's installed, open the windows terminal via search bar, or by typing `wt` into
the command line.

When the Windows Terminal is opened, open the settings, choose your favorite Terminal 
Emulator(Powershell) and select appearence and switch the font to your newly installed font.

#### Oh My Posh

Also our terminal bar is absolutely horrendous in Windows, we'll be configuring it to 
allow for further customization

In order to do this we'll need a module called Oh-My-Posh

From Windows Terminal: 

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

#### Terminal Icons

Our terminal would be nothing if it wasn't for Cool Icons!

Let's install some icons with:

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery
```

### Use & Configuration

#### Checking Profiles

First thing we need to check is if we already have a profile. A Powershell Profile is stored
in the `$PROFILE` variable.

```powershell
test-path $PROFILE
```
If this returns true, skip to the installation process.

If this return false, we'll need to set up a powershell profile by doing:

```powershell
New-Item -Path $PROFILE -Type File -Force
```

#### Editing Profile

Last step, run the following

```bash
ise $PROFILE
```

Add the contents from this repo's `~/WindowsPowerShell/Microsoft.PowerShell_profile.ps1` into your file