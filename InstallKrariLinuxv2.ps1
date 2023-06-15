# Download the background image from our github
$ImageFilePath = "C:\Users\Public\Pictures\krarilinux-wallpaper.png"
$WallpaperURL = "https://raw.githubusercontent.com/krari-linux/krari-linux/main/krarilinux-wallpaper.png"
Invoke-Webrequest -URI $WallpaperURL -Outfile $ImageFilePath

# Set the freshly downloaded image as a background
$setwallpapersrc = @"
using System.Runtime.InteropServices;
public class Wallpaper
{
public const int SetDesktopWallpaper = 20;
public const int UpdateIniFile = 0x01;
public const int SendWinIniChange = 0x02;
[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
public static void SetWallpaper(string path)
{
SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
}
}
"@
Add-Type -TypeDefinition $setwallpapersrc
# take a little nap 
Start-Sleep 1
# This command really sets the wallpaper
[Wallpaper]::SetWallpaper($ImageFilePath)

# Hide icons on your desktop (like a real hacker) by setting the registry path and value name
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
$valueName = "HideIcons"
# Check if the registry value already exists
if (!(Test-Path $registryPath)) {
New-Item -Path $registryPath -Force | Out-Null
}
# Hide the icons by setting the registry value to 1
Set-ItemProperty -Path $registryPath -Name $valueName -Value 1
Get-Process "explorer"| Stop-Process

# take a little nap so that you can enjoy your new wallpaper
Start-Sleep 3

#Open your browser to start hacking like a real one
$HackURL = "https://geektyper.com/fsociety/"
Start-Process $HackURL
