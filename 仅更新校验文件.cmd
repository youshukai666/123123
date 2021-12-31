@echo off

REM 程序变量，不要修改
set param=%1
set exitcode=0
set errmessage=

echo ==========生成校验文件==========
Tool-v3.1.3.exe update
if %errorlevel% NEQ 0 (call :set-failedmessage 生成校验文件时出现错误，程序即将退出 || goto exit)
echo.
goto exit

:set-failedmessage
set exitcode=%errorlevel%
set errmessage=%1
goto :eof

:exit
if "%errmessage%" NEQ "" echo %errmessage%
if "%param%" NEQ "fast" pause
exit /B %exitcode%