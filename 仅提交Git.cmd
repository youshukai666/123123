@echo off

REM ָ��git·��
SET git_exe=git

REM �����������Ҫ�޸�
set param=%1
set exitcode=0
set errmessage=

@REM ���Git��װ
%git_exe% --version > nul
if %errorlevel% NEQ 0 (call :set-failedmessage δ���Զ���⵽Git���밲װGit�����ڽű���ͷָ��Git.exeλ�� || goto exit)
echo ==========Git�ύ(0/2)==========
%git_exe% add .
if %errorlevel% NEQ 0 (call :set-failedmessage Git�ύʱ���ִ��󣬳��򼴽��˳� || goto exit)
echo ==========Git�ύ(1/2)==========
%git_exe% commit -m "Automatically"
if %errorlevel% NEQ 0 (call :set-failedmessage Git�ύʱ���ִ��󣬳��򼴽��˳� || goto exit)
echo.
echo ==========Git����(2/2)==========
%git_exe% push -f
if %errorlevel% NEQ 0 (call :set-failedmessage Git����ʱ���ִ��󣬳��򼴽��˳� || goto exit)
echo ==========Git���ͳɹ���==========
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