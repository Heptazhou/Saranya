@echo off
chcp 65001>nul
set VERSION=v0.32.9-1
set ARGS=-m0=lzma -md1536m -mfb273 -mmt1 -ms -mx9 -stl
echo %VERSION% ^>
echo.
cd dist
del /p *.7z 2>nul
cls
7z a %VERSION%-ttf.7z %ARGS% ./ttf/*.ttf
echo.
7z a %VERSION%-ttf-unhinted.7z %ARGS% ./ttf-unhinted/*.ttf
echo.
pause
