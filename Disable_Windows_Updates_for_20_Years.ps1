# Run as Administrator

$regPath = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$regName = "FlightSettingsMaxPauseDays"
$regValue = 7300

# Ensure the registry path exists
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord

# Confirm the change
$updatedValue = Get-ItemProperty -Path $regPath -Name $regName | Select-Object -ExpandProperty $regName
Write-Output "Updated '$regName' to $updatedValue days in '$regPath'"
