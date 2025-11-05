@echo off
REM Script to launch app and capture filtered logs
REM Usage: scripts\start_and_log.bat

echo Finding ADB...
set ADB_PATH=
for /f "delims=" %%i in ('where adb 2^>nul') do set ADB_PATH=%%i

if "%ADB_PATH%"=="" (
    echo ADB not found in PATH. Trying common locations...
    
    REM Check common Android SDK locations
    if exist "%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe" (
        set ADB_PATH=%LOCALAPPDATA%\Android\Sdk\platform-tools\adb.exe
    ) else if exist "%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe" (
        set ADB_PATH=%USERPROFILE%\AppData\Local\Android\Sdk\platform-tools\adb.exe
    ) else if exist "C:\Android\Sdk\platform-tools\adb.exe" (
        set ADB_PATH=C:\Android\Sdk\platform-tools\adb.exe
    ) else (
        echo ERROR: ADB not found! Please install Android SDK Platform-Tools
        echo Download from: https://developer.android.com/studio/releases/platform-tools
        pause
        exit /b 1
    )
)

echo Using ADB: %ADB_PATH%
echo.

echo Clearing old logs...
"%ADB_PATH%" logcat -c

echo Starting app...
"%ADB_PATH%" shell am start -n com.wowonder.combined/.MainActivity

echo Waiting for app to start...
timeout /t 3 /nobreak >nul

echo Getting app PID...
for /f %%i in ('"%ADB_PATH%" shell pidof -s com.wowonder.combined') do set APP_PID=%%i

if "%APP_PID%"=="" (
    echo ERROR: App not running! Make sure device is connected.
    "%ADB_PATH%" devices
    pause
    exit /b 1
)

echo App PID: %APP_PID%
echo.
echo Capturing logs to long_console.txt...
echo Press Ctrl+C to stop logging
echo.

"%ADB_PATH%" logcat --pid=%APP_PID%

