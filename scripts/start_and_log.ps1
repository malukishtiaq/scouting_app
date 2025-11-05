# Script to launch app and capture filtered logs
# Usage: .\scripts\start_and_log.ps1

Write-Host "Finding ADB..." -ForegroundColor Cyan

# Try to find ADB
$adbPath = $null
$adbPath = Get-Command adb -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source

if (-not $adbPath) {
    Write-Host "ADB not in PATH. Checking common locations..." -ForegroundColor Yellow
    
    $possiblePaths = @(
        "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe",
        "$env:USERPROFILE\AppData\Local\Android\Sdk\platform-tools\adb.exe",
        "C:\Android\Sdk\platform-tools\adb.exe",
        "C:\Program Files\Android\Sdk\platform-tools\adb.exe"
    )
    
    foreach ($path in $possiblePaths) {
        if (Test-Path $path) {
            $adbPath = $path
            break
        }
    }
}

if (-not $adbPath) {
    Write-Host "ERROR: ADB not found!" -ForegroundColor Red
    Write-Host "Please install Android SDK Platform-Tools from:" -ForegroundColor Yellow
    Write-Host "https://developer.android.com/studio/releases/platform-tools" -ForegroundColor Cyan
    exit 1
}

Write-Host "Using ADB: $adbPath" -ForegroundColor Green
Write-Host ""

# Clear old logs
Write-Host "Clearing old logs..." -ForegroundColor Cyan
& $adbPath logcat -c

# Start the app
Write-Host "Starting app..." -ForegroundColor Cyan
& $adbPath shell am start -n com.wowonder.combined/.MainActivity

# Wait for app to start
Write-Host "Waiting for app to start..." -ForegroundColor Cyan
Start-Sleep -Seconds 3

# Get app PID
Write-Host "Getting app PID..." -ForegroundColor Cyan
$appPid = & $adbPath shell pidof -s com.wowonder.combined

if (-not $appPid) {
    Write-Host "ERROR: App not running! Make sure device is connected." -ForegroundColor Red
    & $adbPath devices
    exit 1
}

Write-Host "App PID: $appPid" -ForegroundColor Green
Write-Host ""
Write-Host "Capturing logs to long_console.txt..." -ForegroundColor Cyan
Write-Host "Press Ctrl+C to stop logging" -ForegroundColor Yellow
Write-Host ""

# Start logging (display in terminal)
& $adbPath logcat --pid=$appPid

