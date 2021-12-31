@echo off

REM 指定python路径
SET python_exe=python

REM 程序变量，不要修改
set param=%1
set exitcode=0
set errmessage=

@REM 检测Python安装
%python_exe% --version > nul
if %errorlevel% NEQ 0 (call :set-failedmessage 未能自动检测到Python，请安装Python或者在脚本开头指定Python.exe位置 || goto exit)

REM 安装python依赖
if not exist gitee-pages-action\venv (
    echo 即将开始安装virtualvenv和依赖，准备好以后按任意键开始...
    pause > nul
    echo ==========正在初始化pip依赖==========
    cd gitee-pages-action
    %python_exe% -m virtualenv venv
    call venv\Scripts\activate.bat
    pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
    cd ..
    echo ==========pip依赖安装完成！==========
    echo.
)

echo ==========更新GiteePages==========
cd gitee-pages-action
call venv\Scripts\activate.bat
if %errorlevel% NEQ 0 (call :set-failedmessage 启动virtualenv时出错，程序即将退出 || goto exit)
%python_exe% main.py
if %errorlevel% NEQ 0 (call :set-failedmessage 更新GiteePages时出现错误，程序即将退出 || goto exit)
echo ==========GiteePages更新成功！==========
goto exit

:set-failedmessage
set exitcode=%errorlevel%
set errmessage=%1
goto :eof

:exit
if "%errmessage%" NEQ "" echo %errmessage%
if "%param%" NEQ "fast" pause
exit /B %exitcode%