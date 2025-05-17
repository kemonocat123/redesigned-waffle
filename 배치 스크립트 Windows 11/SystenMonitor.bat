@echo off
title System Performance Monitor
mode con cols=100 lines=30
color 0A

:: Check system encoding to avoid text issues
chcp 65001 >nul

:menu
cls
echo ======================================================
echo                   SYSTEM MONITOR
echo ======================================================
echo.
echo [1] View CPU Usage
echo [2] View Memory Usage
echo [3] View Disk Space
echo [4] View Network Info
echo [5] List Running Processes
echo [6] View Installed Drivers
echo [7] Check Battery Status
echo [8] System Information
echo [9] Exit
echo.
set /p choice=Select an option: 

if "%choice%"=="1" goto cpu
if "%choice%"=="2" goto memory
if "%choice%"=="3" goto disk
if "%choice%"=="4" goto network
if "%choice%"=="5" goto processes
if "%choice%"=="6" goto drivers
if "%choice%"=="7" goto battery
if "%choice%"=="8" goto sysinfo
if "%choice%"=="9" exit
goto menu

:cpu
cls
echo CPU Usage:
wmic cpu get loadpercentage
echo.
pause
goto menu

:memory
cls
echo Memory Usage:
wmic OS get FreePhysicalMemory,TotalVisibleMemorySize
echo.
pause
goto menu

:disk
cls
echo Disk Space Information:
wmic logicaldisk get caption,freespace,size
echo.
pause
goto menu

:network
cls
echo Network Information:
ipconfig /all
echo.
pause
goto menu

:processes
cls
echo Running Processes:
tasklist
echo.
pause
goto menu

:drivers
cls
echo Installed Drivers:
driverquery
echo.
pause
goto menu

:battery
cls
echo Battery Status:
wmic path Win32_Battery get EstimatedChargeRemaining
echo.
pause
goto menu

:sysinfo
cls
echo System Information:
systeminfo
echo.
pause
goto menu
