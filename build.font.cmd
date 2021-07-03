@echo off
chcp 65001>nul
cmd /c pnpm up
echo.
pause&echo.
julia config.update.jl
julia pre-build.mv.jl
cls
cmd /c pnpm run build ttf ttc
echo.
echo.
julia post-build.mv.jl
julia post-build.clean.jl
echo.
pause&echo.
echo Start building 7z . . .
echo.
build.7z
