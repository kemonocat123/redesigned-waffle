@echo off
title Ultra System Control - Advanced Mode
mode con cols=120 lines=40
color 0A

:: Set encoding to avoid text issues
chcp 65001 >nul

:: Create log file for session tracking
echo System Control started at %date% %time% > syslog.txt

:menu
cls
echo ================================================================
echo                  ULTRA SYSTEM CONTROL PANEL
echo ================================================================
echo [1] Real-Time CPU & Memory Monitoring
echo [2] Disk Health & Storage Distribution
echo [3] Network Diagnostics & Speed Test
echo [4] Advanced Process Analytics & Task Management
echo [5] System Alerts & Performance Warnings
echo [6] Battery & Power Consumption Analysis
echo [7] Hardware & System Info
echo [8] Error Handling & Recovery Tools
echo [9] File System Scan & Integrity Check
echo [10] View System Logs
echo [11] Exit
echo ---------------------------------------------------------------
set /p choice=Select an option: 

if "%choice%"=="1" goto realtime
if "%choice%"=="2" goto disk
if "%choice%"=="3" goto network
if "%choice%"=="4" goto processes
if "%choice%"=="5" goto alerts
if "%choice%"=="6" goto battery
if "%choice%"=="7" goto sysinfo
if "%choice%"=="8" goto recovery
if "%choice%"=="9" goto filescan
if "%choice%"=="10" goto logs
if "%choice%"=="11" exit
goto menu

:realtime
cls
echo ====================================================
echo                REAL-TIME CPU & MEMORY STATUS
echo ====================================================
for /L %%x in (1,1,10) do (
    echo System Usage Check:
    wmic cpu get LoadPercentage
    wmic OS get FreePhysicalMemory,TotalVisibleMemorySize
    timeout 2
)
echo Performance monitoring logged at %date% %time% >> syslog.txt
pause
goto menu

:disk
cls
echo ====================================================
echo            DISK HEALTH & STORAGE ANALYSIS
echo ====================================================
wmic logicaldisk get caption, freespace, size, description
wmic diskdrive get model, size, status
echo Disk health check logged at %date% %time% >> syslog.txt
pause
goto menu

:network
cls
echo ====================================================
echo            NETWORK DIAGNOSTICS & SPEED TEST
echo ====================================================
echo Running speed test...
ping google.com -n 5
netsh interface ipv4 show subinterfaces
echo Network test logged at %date% %time% >> syslog.txt
pause
goto menu

:processes
cls
echo ====================================================
echo       ADVANCED PROCESS ANALYTICS & MANAGEMENT
echo ====================================================
echo Running Processes:
tasklist /v
echo ----------------------------------------------------
set /p proc="Enter process name to terminate (e.g., chrome.exe): "
if "%proc%"=="explorer.exe" (
    echo ERROR: Cannot terminate explorer.exe!
    timeout 3 >nul
    goto menu
)
taskkill /IM %proc% /F
echo Process %proc% terminated at %date% %time% >> syslog.txt
pause
goto menu

:alerts
cls
echo ====================================================
echo         SYSTEM ALERTS & PERFORMANCE WARNINGS
echo ====================================================
wmic cpu get LoadPercentage | find /v "LoadPercentage" > cpu.txt
set /p usage=<cpu.txt
if %usage% GTR 80 (
    echo WARNING: CPU usage is high (%usage%)! Consider closing programs.
    echo High CPU usage detected at %date% %time% >> syslog.txt
)
wmic OS get FreePhysicalMemory | find /v "FreePhysicalMemory" > mem.txt
set /p freeMem=<mem.txt
if %freeMem% LSS 500000 (
    echo WARNING: Low free memory available! Close applications.
    echo Low memory warning at %date% %time% >> syslog.txt
)
pause
goto menu

:battery
cls
echo ====================================================
echo           BATTERY & POWER USAGE MONITORING
echo ====================================================
wmic path Win32_Battery get EstimatedChargeRemaining, BatteryStatus
echo Battery analysis logged at %date% %time% >> syslog.txt
pause
goto menu

:sysinfo
cls
echo ====================================================
echo               HARDWARE & SYSTEM INFO
echo ====================================================
systeminfo
wmic computersystem get manufacturer, model
echo System scan logged at %date% %time% >> syslog.txt
pause
goto menu

:recovery
cls
echo ====================================================
echo         ERROR HANDLING & SYSTEM RECOVERY
echo ====================================================
echo Running diagnostics...
sfc /scannow
echo Error handling logged at %date% %time% >> syslog.txt
pause
goto menu

:filescan
cls
echo ====================================================
echo           FILE SYSTEM SCAN & INTEGRITY CHECK
echo ====================================================
echo Scanning for disk errors...
chkdsk C: /f /r
echo File system scan logged at %date% %time% >> syslog.txt
pause
goto menu

:logs
cls
echo ====================================================
echo               SYSTEM LOG HISTORY
echo ====================================================
type syslog.txt
echo ---------------------------------------------------
pause
goto menu
