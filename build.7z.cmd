@echo off
chcp  65001>nul
set   VERSION=v15.0.2-1
set   NAME=saranya
set   ARGS=-m0=lzma -md3840m -mfb273 -mmt2 -ms -mx9 -stl
cd    dist
del   /p          %VERSION%*.7z 2>nul
pause&7z a %ARGS% %VERSION%.7z  ./ttc/%NAME%.ttc ./ttc/%NAME%-h.ttc
echo.&7z a %ARGS% %VERSION%-ttf.7z               ./ttf/%NAME%-*.ttf
echo.&7z a %ARGS% %VERSION%-ttf-hinted.7z ./ttf-hinted/%NAME%-*.ttf
echo.
echo.
cmd
