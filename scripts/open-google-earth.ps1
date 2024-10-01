<#
.SYNOPSIS
	Opens Google Earth
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Earth website.
.EXAMPLE
	PS> ./open-google-earth
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://earth.google.com/web/"
exit 0 # success
