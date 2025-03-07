# Run as Administrator

# Overview:
# - The Script works as Intended (Feb-2025)
# - Prevents automatic upgrade to Windows 11 by setting the TargetReleaseVersionInfo to 22H2
# - Ensures the policy is applied correctly.
# - Uses best practices (checking if the path exists, confirming the change).
# - Uses Microsoft’s officially recommended registry settings.

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
$regName = "TargetReleaseVersion"
$regValue = 1

$regName2 = "TargetReleaseVersionInfo"
$regValue2 = "22H2"  # Change to your preferred Windows 10 version

$regName3 = "ProductVersion"
$regValue3 = "Windows 10"  # Ensures Windows Update only targets Windows 10 updates


# Ensure the registry path exists
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry values
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
Set-ItemProperty -Path $regPath -Name $regName2 -Value $regValue2 -Type String
Set-ItemProperty -Path $regPath -Name $regName3 -Value $regValue3 -Type String  # Added ProductVersion fix


# Confirm the change
$updatedVersion = Get-ItemProperty -Path $regPath -Name $regName2 | Select-Object -ExpandProperty $regName2
$updatedProduct = Get-ItemProperty -Path $regPath -Name $regName3 | Select-Object -ExpandProperty $regName3

Write-Output "Windows Update is now locked to Windows 10 version: $updatedVersion ($updatedProduct)"
