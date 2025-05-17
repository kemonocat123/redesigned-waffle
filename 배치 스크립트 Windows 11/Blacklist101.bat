@echo off
title Blacklist101 - System Protection
mode 80,25

:menu
cls
echo =====================================
echo         BLACKLIST101 ACTIVE
echo =====================================
echo.
echo This tool prevents execution of harmful system commands.
echo -------------------------------------
set /p cmd="Enter a command to check: "
echo.

:: Blacklisted Commands - Immediate Block
if "%cmd%"=="del C:\Windows" goto blocked
if "%cmd%"=="del C:\System32" goto blocked
if "%cmd%"=="rd C:\Windows" goto blocked
if "%cmd%"=="rd C:\System32" goto blocked
if "%cmd%"=="format C:" goto blocked
if "%cmd%"=="shutdown -s -f -t 00" goto blocked
if "%cmd%"=="erase C:\Windows" goto blocked
if "%cmd%"=="erase C:\System32" goto blocked

echo Command "%cmd%" is **SAFE** to execute.
timeout 2 >nul
goto menu

:blocked
cls
echo WARNING: This command is BLACKLISTED and **cannot** be executed.
echo.
echo Attempted command: %cmd%
timeout 3 >nul
goto menu
