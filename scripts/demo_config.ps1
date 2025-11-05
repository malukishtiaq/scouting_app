# Customer Demo Configuration Script (PowerShell)
# Usage: .\demo_config.ps1 [demo_number]
# Example: .\demo_config.ps1 1

param(
    [Parameter(Mandatory=$true)]
    [int]$DemoNumber
)

$AppSettingsFile = "lib\app_settings.dart"

switch ($DemoNumber) {
    1 {
        Write-Host "Configuring Demo 1: News Feed Only" -ForegroundColor Green
        # Update app_settings.dart for demo 1
        (Get-Content $AppSettingsFile) -replace "newsfeed.*true", "newsfeed: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "signup.*true", "signup: false" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "profile.*true", "profile: false" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "settings.*true", "settings: false" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "chat.*true", "chat: false" | Set-Content $AppSettingsFile
    }
    2 {
        Write-Host "Configuring Demo 2: Sign Up + News Feed" -ForegroundColor Green
        (Get-Content $AppSettingsFile) -replace "newsfeed.*false", "newsfeed: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "signup.*false", "signup: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "profile.*true", "profile: false" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "settings.*true", "settings: false" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "chat.*true", "chat: false" | Set-Content $AppSettingsFile
    }
    3 {
        Write-Host "Configuring Demo 3: Profile + Previous Features" -ForegroundColor Green
        (Get-Content $AppSettingsFile) -replace "newsfeed.*false", "newsfeed: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "signup.*false", "signup: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "profile.*false", "profile: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "settings.*true", "settings: false" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "chat.*true", "chat: false" | Set-Content $AppSettingsFile
    }
    4 {
        Write-Host "Configuring Demo 4: Settings + Previous Features" -ForegroundColor Green
        (Get-Content $AppSettingsFile) -replace "newsfeed.*false", "newsfeed: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "signup.*false", "signup: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "profile.*false", "profile: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "settings.*false", "settings: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "chat.*true", "chat: false" | Set-Content $AppSettingsFile
    }
    5 {
        Write-Host "Configuring Demo 5: Chat + Previous Features" -ForegroundColor Green
        (Get-Content $AppSettingsFile) -replace "newsfeed.*false", "newsfeed: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "signup.*false", "signup: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "profile.*false", "profile: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "settings.*false", "settings: true" | Set-Content $AppSettingsFile
        (Get-Content $AppSettingsFile) -replace "chat.*false", "chat: true" | Set-Content $AppSettingsFile
    }
    default {
        Write-Host "Invalid demo number. Please use 1-5." -ForegroundColor Red
        Write-Host "Available demos:" -ForegroundColor Yellow
        Write-Host "  1 - News Feed Only"
        Write-Host "  2 - Sign Up + News Feed"
        Write-Host "  3 - Profile + Previous Features"
        Write-Host "  4 - Settings + Previous Features"
        Write-Host "  5 - Chat + Previous Features"
        exit 1
    }
}

Write-Host "Demo configuration updated successfully!" -ForegroundColor Green
Write-Host "Run 'flutter build apk --release' to build the demo APK." -ForegroundColor Cyan
