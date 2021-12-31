@echo off

REM 指定git路径
SET git_exe=git

REM 程序变量，不要修改
set param=%1
set exitcode=0
set errmessage=

@REM 检查Git安装
%git_exe% --version > nul
if %errorlevel% NEQ 0 (call :set-failedmessage 未能自动检测到Git，请安装Git或者在脚本开头指定Git.exe位置 || goto exit)
echo ==========Git提交(0/2)==========
%git_exe% add .
if %errorlevel% NEQ 0 (call :set-failedmessage Git提交时出现错误，程序即将退出 || goto exit)
echo ==========Git提交(1/2)==========
%git_exe% commit -m "Automatically"
if %errorlevel% NEQ 0 (call :set-failedmessage Git提交时出现错误，程序即将退出 || goto exit)
echo.
echo ==========Git推送(2/2)==========
%git_exe% push -f
if %errorlevel% NEQ 0 (call :set-failedmessage Git推送时出现错误，程序即将退出 || goto exit)
echo ==========Git推送成功！==========
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