@echo off
color 2f
mode con cols=50 lines=30
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo 请使用右键管理员身份运行！&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
title   NamelessRain
:sc_999
echo.&echo.&echo.
echo         	  简单防火墙1.1
echo.
echo    --------------------------------------------
echo.&echo.
echo             1、使用此脚本默认的防火墙规则
echo.
echo             2、自定义要启用的端口
echo.
echo             3、重置防火墙
echo.
echo             4、启用防火墙
echo.
echo             5、关闭防火墙
echo.
echo             6、查看防火墙
echo.  
echo.
echo             7、更改远程端口
echo.
echo             8、关闭远程协助
echo.
echo.
echo    --------------------------------------------
echo.&echo.&echo.&echo.
::——————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————————
set select=
set str1=12345678
set /p select= 输入数字，按回车:
if not defined select goto sc_bug
echo %select%|findstr "[%str1%]">nul||goto sc_bug
if %select%==1 (goto sc_1)
if %select%==2 (goto sc_2)
if %select%==3 (goto sc_3)
if %select%==4 (goto sc_4)
if %select%==5 (goto sc_5)
if %select%==6 (goto sc_6)
if %select%==7 (goto sc_7)
if %select%==8 (goto sc_8)
:sc_bug
mshta vbscript:msgbox("只能输入1-8的数字",64,"提示")(window.close) 
goto sc_999
::—————————————————————————————————————————————————————————————————sc_1———————————————————————————————————————————————————————————————————————————
::————————————使用此脚本默认的防火墙规则————————————————
:sc_1
cls
mshta vbscript:msgbox("禁用高危端口:134,135,137,138,139,445,593,1025,2745,3127,3389,6129 ""    修改远程端口3389为：2333 ",64,"提示")(window.close)
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh firewall set icmpsetting 8
netsh advfirewall firewall add rule name="bat策略"  dir=in protocol=TCP localport=134,135,137,138,139,445,593,1025,2745,3127,3389,6129 action=block
netsh advfirewall firewall add rule name="bat策略"  dir=out protocol=TCP localport=134,135,137,138,139,445,593,1025,2745,3127,3389,6129 action=block
netsh advfirewall firewall add rule name="远程控制" dir=in protocol=tcp localport=2333 action=allow
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD  /d  0  /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v PortNumber /t REG_DWORD  /d 2333 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD  /d 2333 /f
net stop SessionEnv 
net stop TermService /y
net start SessionEnv 
net start TermService
mshta vbscript:msgbox("配置脚本策略成功：%port% ",64,"提示")(window.close) 
cls
goto sc_999
::————————————自定义要启用的端口—————————————————————————————————————:sc_2———————————————————————————————————————————————————————————————————————————
:sc_2
cls
echo.&echo.&echo.
echo                   【使用说明】
echo    --------------------------------------------
echo.
echo        请输入你要启用的端口【1---65535】之间
echo.
echo          单端口启用：80   
echo.
echo          多端口启用：80,3389
echo.
echo          批量端口启用：5000-5100
echo.
echo          不启用：直接按回车退出
echo.&echo.&echo.&echo.&echo.&echo.&echo.
echo.&echo.
set port=
set str2=1-65535
set /p  port=请输入你要启用的端口，按回车执行:：
if not defined port goto sc_bug2
echo %port%|findstr "[%str2%]">nul||goto sc_bug2
goto sc_2a
:sc_bug2
mshta vbscript:msgbox("只能输入1---65535的数字",64,"提示")(window.close) 
goto sc_999
:sc_2a
::修改指定的防火墙策略
netsh advfirewall firewall set rule name="自定义启用的端口" new localport=%port%
::判断修改防火墙策略命令是否成功执行，如果没有执行成功说明策略不存在，这里重新添加新策略。
IF ERRORLEVEL 1  netsh advfirewall firewall add rule name="自定义启用的端口" dir=out protocol=tcp localport=%port% action=allow
mshta vbscript:msgbox("成功启用端口：%port% ",64,"提示")(window.close) 
cls
goto sc_999
::————————————还原防火墙默认规则——————————————————————————————————————:sc_3——————————————————————————————————————————————————————————————————————————
:sc_3
netsh advfirewall reset
mshta vbscript:msgbox("重置成功",64,"提示")(window.close) 
cls
goto sc_999
::————————————启用防火墙——————————————————————————————————————————————:sc_4—————————————————————————————————————————————————————————————————————————
:sc_4
netsh advfirewall set allprofiles state on
mshta vbscript:msgbox("启用防火墙成功",64,"提示")(window.close) 
firewall.cpl
cls
goto sc_999
::————————————关闭防火墙——————————————————————————————————————————————:sc_5——————————————————————————————————————————————————————————————————————————
:sc_5
NetSh Advfirewall set allprofiles state off
mshta vbscript:msgbox("关闭防火墙成功",64,"提示")(window.close) 
firewall.cpl
cls
goto sc_999
::————————————查看防火墙——————————————————————————————————————————————:sc_6——————————————————————————————————————————————————————————————————————————
:sc_6 
cls
firewall.cpl
WF.msc
goto sc_999
::————————————更改远程端口————————————————————————————————————————————:sc_7——————————————————————————————————————————————————————————————————————————
:sc_7
cls
echo.&echo.&echo.
echo                   【使用说明】
echo    --------------------------------------------
echo.
echo        请输入你要启用的端口【1---65535】之间
echo.
echo          例如：3389
echo.
echo          不修改：直接按回车退出
echo.&echo.&echo.&echo.&echo.&echo.&echo.
set port=
set str7=1-65535
set /p  port=请输入你要修改的的端口，按回车执行：
if not defined port goto sc_bug7
echo %port%|findstr "[%str7%]">nul||goto sc_bug7
goto sc_7a
:sc_bug7
mshta vbscript:msgbox("只能输入1---65535的数字",64,"提示")(window.close) 
goto sc_999
:sc_7a
::修改注册表启用远程桌面。
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD  /d  0  /f
::修改远程桌面端口的注册表，共两个
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v PortNumber /t REG_DWORD  /d %port% /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD  /d %port% /f
::修改指定的防火墙策略
netsh advfirewall firewall set rule name="远程控制端口" new localport=%port%
::判断修改防火墙策略命令是否成功执行，如果没有执行成功说明策略不存在，这里重新添加新策略。
IF ERRORLEVEL 1  netsh advfirewall firewall add rule name="远程控制端口" dir=in protocol=tcp localport=%port% action=allow
::停止远程服务，启用远程服务，没有有重启我只能这样搞啊 哭了！
net stop SessionEnv 
net stop TermService /y
net start SessionEnv 
net start TermService
mshta vbscript:msgbox("远程端口已修改成：%port% ",64,"提示")(window.close) 
cls
goto sc_999
::————————————关闭远程协助————————————————————————————————————————————:sc_8——————————————————————————————————————————————————————————————————————————
:sc_8
cls
::修改注册表启用远程桌面。
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD  /d  1  /f
net stop SessionEnv 
net stop TermService /y
mshta vbscript:msgbox("远程协助已关闭",64,"提示")(window.close) 
goto sc_999