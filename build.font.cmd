@echo off
chcp 65001>nul
pause&cls
cmd /c pnpm up
echo.
pause&cls
cmd /c pnpm run build ttf
echo.
julia build.mv.jl
echo.&cmd
