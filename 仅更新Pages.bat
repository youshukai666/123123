@echo off

REM ָ��python·��
SET python_exe=python

REM �����������Ҫ�޸�
set param=%1
set exitcode=0
set errmessage=

@REM ���Python��װ
%python_exe% --version > nul
if %errorlevel% NEQ 0 (call :set-failedmessage δ���Զ���⵽Python���밲װPython�����ڽű���ͷָ��Python.exeλ�� || goto exit)

REM ��װpython����
if not exist gitee-pages-action\venv (
    echo ������ʼ��װvirtualvenv��������׼�����Ժ��������ʼ...
    pause > nul
    echo ==========���ڳ�ʼ��pip����==========
    cd gitee-pages-action
    %python_exe% -m virtualenv venv
    call venv\Scripts\activate.bat
    pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
    cd ..
    echo ==========pip������װ��ɣ�==========
    echo.
)

echo ==========����GiteePages==========
cd gitee-pages-action
call venv\Scripts\activate.bat
if %errorlevel% NEQ 0 (call :set-failedmessage ����virtualenvʱ�������򼴽��˳� || goto exit)
%python_exe% main.py
if %errorlevel% NEQ 0 (call :set-failedmessage ����GiteePagesʱ���ִ��󣬳��򼴽��˳� || goto exit)
echo ==========GiteePages���³ɹ���==========
goto exit

:set-failedmessage
set exitcode=%errorlevel%
set errmessage=%1
goto :eof

:exit
if "%errmessage%" NEQ "" echo %errmessage%
if "%param%" NEQ "fast" pause
exit /B %exitcode%