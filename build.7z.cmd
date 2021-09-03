@echo off
chcp 65001>nul
set VERSION=v10.0.0-3
set NAME=saranya
set ARGS=-m0=lzma -md1536m -mfb273 -mmt1 -ms -mx9 -stl
cd dist
del  %VERSION%*.7z /p 2>nul
pause
7z a %VERSION%.7z %ARGS% ./ttc/%NAME%.ttc ./ttc/%NAME%-h.ttc
start cmd /k 7z a %VERSION%-ttf.7z %ARGS% ./ttf/%NAME%-*.ttf
start cmd /k 7z a %VERSION%-ttf-hinted.7z %ARGS% ./ttf-hinted/%NAME%-*.ttf
echo.
echo.
cmd
