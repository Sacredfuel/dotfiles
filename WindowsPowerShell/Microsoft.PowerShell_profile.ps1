oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\half-life.omp.json" | Invoke-Expression

function admin
{
	if($args.Count -gt 0)
	{
		$argList = "& '" + $args + "'"
		Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $argList
	}
	else{
		Start-Process "$psHome\powershell.exe" -Verb runAs
	}
}

function touch($file) {
        "" | Out-File $file -Encoding ASCII
}

function grep($regex, $dir) {
        if ( $dir ) {
                ls $dir | select-string $regex
                return
        }
        $input | select-string $regex
}

function unzip ($file) {
        $dirname = (Get-Item $file).Basename
        echo("Extracting", $file, "to", $dirname)
        New-Item -Force -ItemType directory -Path $dirname
        expand-archive $file -OutputPath $dirname -ShowProgress
}

function reload-profile {
        & $profile
}

function cd...  { cd ..\.. }
function cd.... { cd ..\..\.. }

Import-Module -Name Terminal-Icons

Set-Alias -Name vim -Value nvim
Set-Alias g git


Set-Alias -Name vim -Value nvim
Set-Alias g git


Set-Alias -Name su -Value admin
Set-Alias -Name sudo -Value admin

