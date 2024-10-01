<#
.SYNOPSIS
	Check the PowerShell status
.DESCRIPTION
	This PowerShell script queries the PowerShell status and prints it.
.EXAMPLE
	PS> ./check-powershell.ps1
	✅ PowerShell 5.1.19041.2673 Desktop edition (1 profile, 10 modules, 1458 cmdlets, 172 aliases)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function GetNumberOfProfiles {
	[int]$count = 0
	if (Test-Path $PROFILE.AllUsersAllHosts) { $count++ }
	if (Test-Path $PROFILE.AllUsersCurrentHost) { $count++ }
	if (Test-Path $PROFILE.CurrentUserAllHosts) { $count++ }
	if (Test-Path $PROFILE.CurrentUserCurrentHost) { $count++ }
	return $count
}

try {
	$version = $PSVersionTable.PSVersion
	$edition = $PSVersionTable.PSEdition
	$numProfiles = GetNumberOfProfiles
	$numModules = (Get-Module).Count
	$numAliases = (Get-Alias).Count
	if ($IsLinux) {
		"✅ PowerShell $version $edition edition ($numProfiles profile, $numModules modules, $numAliases aliases)"
	} else {
		$numCmdlets = (Get-Command -Command-Type cmdlet).Count
		"✅ PowerShell $version $edition edition ($numProfiles profile, $numModules modules, $numCmdlets cmdlets, $numAliases aliases)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
