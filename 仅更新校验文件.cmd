@echo off

REM �����������Ҫ�޸�
set param=%1
set exitcode=0
set errmessage=

echo ==========����У���ļ�==========
Tool-v3.1.3.exe update
if %errorlevel% NEQ 0 (call :set-failedmessage ����У���ļ�ʱ���ִ��󣬳��򼴽��˳� || goto exit)
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