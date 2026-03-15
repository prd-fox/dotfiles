# Remove Windows Bloatware
# Run as Administrator in PowerShell:
#   Set-ExecutionPolicy Bypass -Scope Process -Force
#   .\remove-bloatware.ps1

$apps = @(
    # Microsoft bloatware
    "Microsoft.3DBuilder"
    "Microsoft.BingFinance"
    "Microsoft.BingFoodAndDrink"
    "Microsoft.BingHealthAndFitness"
    "Microsoft.BingMaps"
    "Microsoft.BingNews"
    "Microsoft.BingSports"
    "Microsoft.BingTravel"
    "Microsoft.BingWeather"
    "Microsoft.Copilot"
    "Microsoft.GamingApp"
    "Microsoft.GetHelp"
    "Microsoft.Getstarted"
    "Microsoft.Messaging"
    "Microsoft.Microsoft3DViewer"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.MicrosoftStickyNotes"
    "Microsoft.MixedReality.Portal"
    "Microsoft.MSPaint"
    "Microsoft.Office.OneNote"
    "Microsoft.OneConnect"
    "Microsoft.People"
    "Microsoft.Print3D"
    "Microsoft.SkypeApp"
    "Microsoft.Todos"
    "Microsoft.Windows.Maps"
    "Microsoft.WindowsAlarms"
    "Microsoft.WindowsCamera"
    "Microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.WindowsSoundRecorder"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxApp"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "MicrosoftTeams"
    "Microsoft.Teams"

    # Third-party bloatware
    "Amazon.com.Amazon"
    "BytedancePte.Ltd.TikTok"
    "Disney.37853FC22B2CE"
    "Dolby.DolbyAccess"
    "Duolingo-LearnLanguagesforFree"
    "EclipseManager"
    "Facebook.Facebook"
    "Flipboard.Flipboard"
    "king.com.BubbleWitch3Saga"
    "king.com.CandyCrushFriends"
    "king.com.CandyCrushSaga"
    "king.com.CandyCrushSodaSaga"
    "Minecraft.Education"
    "PandoraMediaInc"
    "PicsArt-PhotoStudio"
    "SpotifyAB.SpotifyMusic"
    "Twitter.Twitter"
)

$removed = 0
$skipped = 0

foreach ($app in $apps) {
    $pkg = Get-AppxPackage -Name $app -AllUsers -ErrorAction SilentlyContinue
    if ($pkg) {
        Write-Host "Removing: $app" -ForegroundColor Yellow
        try {
            Remove-AppxPackage -Package $pkg.PackageFullName -AllUsers -ErrorAction Stop
            # Also remove provisioned package so it won't reinstall for new users
            $provisioned = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -eq $app }
            if ($provisioned) {
                Remove-AppxProvisionedPackage -Online -PackageName $provisioned.PackageName | Out-Null
            }
            $removed++
        } catch {
            Write-Host "  Failed: $_" -ForegroundColor Red
        }
    } else {
        $skipped++
    }
}

Write-Host ""
Write-Host "Done. Removed: $removed | Not found (already absent): $skipped" -ForegroundColor Green

# Optional: disable OneDrive
Write-Host "Disabling OneDrive..." -ForegroundColor Cyan
taskkill /f /im OneDrive.exe 2>$null
Start-Process "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" "/uninstall" -Wait -ErrorAction SilentlyContinue
Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" "/uninstall" -Wait -ErrorAction SilentlyContinue
