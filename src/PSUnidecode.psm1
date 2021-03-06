#--Init
$Private:public = @()
$Private:private = @()
#-

#Load assemblies
$Private:public += Get-ChildItem -Path "$PSScriptRoot\public\" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue
$Private:private += Get-ChildItem -Path "$PSScriptRoot\private\" -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue

foreach ($import in @($Private:public + $Private:private)) {
    Try {
        . $import.fullname
    }
    Catch {
        Throw "Failed to import function $($import.fullname): $_"
    }
}

##Only Export Public Functions
Export-ModuleMember -Function $Public.Basename

#-- Strict
Set-StrictMode -Version 2.0
$Global:ErrorActionPreference = "Stop"
#--
