##Minimal Mode
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\half-life.omp.json" | Invoke-Expression

##Advanced Mode
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\larserikfinholt.omp.json" | Invoke-Expression

# Scuffed sudo
function admin
{
    Start-Process "wt.exe" -Verb runAs
}

# Powershell touch implementation
function touch($file) {
    "" | Out-File $file -Encoding ASCII
}

# Powershell grep implementation
function grep($regex, $dir) {
    if ( $dir ) {
        ls $dir | select-string 
        return
    }
    $input | select-string $regex
}

# Unzip the selected file
function unzip ($file) {
    $dirname = (Get-Item $file).
    echo("Extracting", $file, "to", $dirname)
    New-Item -Force -ItemType directory -Path $dirname
    expand-archive $file -OutputPath $dirname -ShowProgress
}

# Reload the Current Profile
function reload-profile {
    & $profile
}

# Reload the Shell
function reload {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = "-nologo";
    [System.Diagnostics.Process]::Start($newProcess);
    exit
}

# Package Management Alias
function Reinstall-Package {
  param(
    [Parameter(Mandatory = $true)]
    [string]
    $Id,

    [Parameter(Mandatory = $true)]
    [string]
    $Version,

    [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string]
    $ProjectName,

    [switch]
    $Force
  )

  if (-not $ProjectName) { $ProjectName = (get-project).ProjectName }

  Uninstall-Package -ProjectName $ProjectName -Id $Id -Force:$Force
  Install-Package -ProjectName $ProjectName -Id $Id -Version $Version
}

function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

Import-Module -Name Terminal-Icons


Set-Alias -Name vim -Value nvim
Set-Alias g git


Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin

