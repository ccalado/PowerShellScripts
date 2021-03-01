#!/bin/powershell
<#
.SYNTAX         ./list-branches.ps1 [<repo-dir>] [<pattern>]
.DESCRIPTION	lists all branches of the current/given Git repository 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Pattern = "*")

try {
	$null = $(git --version)
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	set-location $RepoDir

	$Branches = $(git branch --list "$Pattern" --remotes --no-color --no-column)
	if ($lastExitCode -ne "0") { throw "'git branch --list' failed" }

	foreach($Branch in $Branches) {
		if ("$Branch" -match "origin/HEAD") { continue }
		write-output "$($Branch.substring(9))"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
