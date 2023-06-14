# Download the background image from our github
$filePath = "~\images"
wget -O "$filepath" "https://raw.githubusercontent.com/krari-linux/krari-linux/main/krarilinux-wallpaper.png"
# Set the image as a background
$signature = @"
[DllImport("user32.dll", CharSet = CharSet.Auto)]
public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
"@
$systemParametersInfo = Add-Type -MemberDefinition $signature -Name Wallpaper -Namespace WinAPI -PassThru
$null = $systemParametersInfo::SystemParametersInfo(20, 0, $filePath, 3)

# Hide icons on your desktop (like a real hacker) by setting the registry path and value name
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$valueName = "HideIcons"
# Check if the registry value already exists
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}
# Hide the icons by setting the registry value to 1
Set-ItemProperty -Path $registryPath -Name $valueName -Value 1

#Open your browser to start hacking
$url = "https://geektyper.com/fsociety/"
Start-Process $url
