@echo off
setlocal enabledelayedexpansion

:: 切换到UTF-8码页
chcp 65001 >nul

:: 定义options.txt文件路径
set "optionsPath=%appdata%\MinecraftPE_Netease\minecraftpe\options.txt"
set "tempFile=%optionsPath%.tmp"

:: 检查options.txt文件是否存在
if not exist "%optionsPath%" (
    echo 错误：options.txt 文件不存在！
    pause
    exit /b
)

:: 创建一个临时文件用于存储修改后的内容
del "%tempFile%" 2>nul

:: 初始化标志变量
set "found=0"

:: 逐行读取options.txt文件并修改game_language行
for /f "delims=" %%i in ('type "%optionsPath%"') do (
    set "line=%%i"
    if "!line!" neq "" (
        echo !line! | findstr /c:"game_language" >nul
        if !errorlevel! equ 0 (
            set "found=1"
            set "line=game_language:zh_CN"
        )
    )
    echo !line! >> "%tempFile%"
)

:: 如果未找到game_language行，则添加到文件末尾
if !found! equ 0 (
    echo game_language:zh_CN >> "%tempFile%"
)

:: 将临时文件内容复制回原文件
copy /y "%tempFile%" "%optionsPath%" >nul
del "%tempFile%"

echo 修改完成！
pause
