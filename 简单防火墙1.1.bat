@echo off
color 2f
mode con cols=50 lines=30
Rd "%WinDir%\system32\test_permissions" >NUL 2>NUL
Md "%WinDir%\System32\test_permissions" 2>NUL||(Echo ��ʹ���Ҽ�����Ա������У�&&Pause >nul&&Exit)
Rd "%WinDir%\System32\test_permissions" 2>NUL
title   NamelessRain
:sc_999
echo.&echo.&echo.
echo         	  �򵥷���ǽ1.1
echo.
echo    --------------------------------------------
echo.&echo.
echo             1��ʹ�ô˽ű�Ĭ�ϵķ���ǽ����
echo.
echo             2���Զ���Ҫ���õĶ˿�
echo.
echo             3�����÷���ǽ
echo.
echo             4�����÷���ǽ
echo.
echo             5���رշ���ǽ
echo.
echo             6���鿴����ǽ
echo.  
echo.
echo             7������Զ�̶˿�
echo.
echo             8���ر�Զ��Э��
echo.
echo.
echo    --------------------------------------------
echo.&echo.&echo.&echo.
::����������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������
set select=
set str1=12345678
set /p select= �������֣����س�:
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
mshta vbscript:msgbox("ֻ������1-8������",64,"��ʾ")(window.close) 
goto sc_999
::����������������������������������������������������������������������������������������������������������������������������������sc_1������������������������������������������������������������������������������������������������������������������������������������������������������
::������������������������ʹ�ô˽ű�Ĭ�ϵķ���ǽ���򡪡�����������������������������
:sc_1
cls
mshta vbscript:msgbox("���ø�Σ�˿�:134,135,137,138,139,445,593,1025,2745,3127,3389,6129 ""    �޸�Զ�̶˿�3389Ϊ��2333 ",64,"��ʾ")(window.close)
netsh advfirewall reset
netsh advfirewall set allprofiles state on
netsh firewall set icmpsetting 8
netsh advfirewall firewall add rule name="bat����"  dir=in protocol=TCP localport=134,135,137,138,139,445,593,1025,2745,3127,3389,6129 action=block
netsh advfirewall firewall add rule name="bat����"  dir=out protocol=TCP localport=134,135,137,138,139,445,593,1025,2745,3127,3389,6129 action=block
netsh advfirewall firewall add rule name="Զ�̿���" dir=in protocol=tcp localport=2333 action=allow
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD  /d  0  /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v PortNumber /t REG_DWORD  /d 2333 /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD  /d 2333 /f
net stop SessionEnv 
net stop TermService /y
net start SessionEnv 
net start TermService
mshta vbscript:msgbox("���ýű����Գɹ���%port% ",64,"��ʾ")(window.close) 
cls
goto sc_999
::�������������������������Զ���Ҫ���õĶ˿ڡ�������������������������������������������������������������������������:sc_2������������������������������������������������������������������������������������������������������������������������������������������������������
:sc_2
cls
echo.&echo.&echo.
echo                   ��ʹ��˵����
echo    --------------------------------------------
echo.
echo        ��������Ҫ���õĶ˿ڡ�1---65535��֮��
echo.
echo          ���˿����ã�80   
echo.
echo          ��˿����ã�80,3389
echo.
echo          �����˿����ã�5000-5100
echo.
echo          �����ã�ֱ�Ӱ��س��˳�
echo.&echo.&echo.&echo.&echo.&echo.&echo.
echo.&echo.
set port=
set str2=1-65535
set /p  port=��������Ҫ���õĶ˿ڣ����س�ִ��:��
if not defined port goto sc_bug2
echo %port%|findstr "[%str2%]">nul||goto sc_bug2
goto sc_2a
:sc_bug2
mshta vbscript:msgbox("ֻ������1---65535������",64,"��ʾ")(window.close) 
goto sc_999
:sc_2a
::�޸�ָ���ķ���ǽ����
netsh advfirewall firewall set rule name="�Զ������õĶ˿�" new localport=%port%
::�ж��޸ķ���ǽ���������Ƿ�ɹ�ִ�У����û��ִ�гɹ�˵�����Բ����ڣ�������������²��ԡ�
IF ERRORLEVEL 1  netsh advfirewall firewall add rule name="�Զ������õĶ˿�" dir=out protocol=tcp localport=%port% action=allow
mshta vbscript:msgbox("�ɹ����ö˿ڣ�%port% ",64,"��ʾ")(window.close) 
cls
goto sc_999
::��������������������������ԭ����ǽĬ�Ϲ��򡪡�������������������������������������������������������������������������:sc_3����������������������������������������������������������������������������������������������������������������������������������������������������
:sc_3
netsh advfirewall reset
mshta vbscript:msgbox("���óɹ�",64,"��ʾ")(window.close) 
cls
goto sc_999
::���������������������������÷���ǽ��������������������������������������������������������������������������������������������:sc_4��������������������������������������������������������������������������������������������������������������������������������������������������
:sc_4
netsh advfirewall set allprofiles state on
mshta vbscript:msgbox("���÷���ǽ�ɹ�",64,"��ʾ")(window.close) 
firewall.cpl
cls
goto sc_999
::�������������������������رշ���ǽ��������������������������������������������������������������������������������������������:sc_5����������������������������������������������������������������������������������������������������������������������������������������������������
:sc_5
NetSh Advfirewall set allprofiles state off
mshta vbscript:msgbox("�رշ���ǽ�ɹ�",64,"��ʾ")(window.close) 
firewall.cpl
cls
goto sc_999
::�������������������������鿴����ǽ��������������������������������������������������������������������������������������������:sc_6����������������������������������������������������������������������������������������������������������������������������������������������������
:sc_6 
cls
firewall.cpl
WF.msc
goto sc_999
::����������������������������Զ�̶˿ڡ���������������������������������������������������������������������������������������:sc_7����������������������������������������������������������������������������������������������������������������������������������������������������
:sc_7
cls
echo.&echo.&echo.
echo                   ��ʹ��˵����
echo    --------------------------------------------
echo.
echo        ��������Ҫ���õĶ˿ڡ�1---65535��֮��
echo.
echo          ���磺3389
echo.
echo          ���޸ģ�ֱ�Ӱ��س��˳�
echo.&echo.&echo.&echo.&echo.&echo.&echo.
set port=
set str7=1-65535
set /p  port=��������Ҫ�޸ĵĵĶ˿ڣ����س�ִ�У�
if not defined port goto sc_bug7
echo %port%|findstr "[%str7%]">nul||goto sc_bug7
goto sc_7a
:sc_bug7
mshta vbscript:msgbox("ֻ������1---65535������",64,"��ʾ")(window.close) 
goto sc_999
:sc_7a
::�޸�ע�������Զ�����档
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD  /d  0  /f
::�޸�Զ������˿ڵ�ע���������
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp" /v PortNumber /t REG_DWORD  /d %port% /f
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" /v PortNumber /t REG_DWORD  /d %port% /f
::�޸�ָ���ķ���ǽ����
netsh advfirewall firewall set rule name="Զ�̿��ƶ˿�" new localport=%port%
::�ж��޸ķ���ǽ���������Ƿ�ɹ�ִ�У����û��ִ�гɹ�˵�����Բ����ڣ�������������²��ԡ�
IF ERRORLEVEL 1  netsh advfirewall firewall add rule name="Զ�̿��ƶ˿�" dir=in protocol=tcp localport=%port% action=allow
::ֹͣԶ�̷�������Զ�̷���û����������ֻ�������㰡 ���ˣ�
net stop SessionEnv 
net stop TermService /y
net start SessionEnv 
net start TermService
mshta vbscript:msgbox("Զ�̶˿����޸ĳɣ�%port% ",64,"��ʾ")(window.close) 
cls
goto sc_999
::�������������������������ر�Զ��Э������������������������������������������������������������������������������������������:sc_8����������������������������������������������������������������������������������������������������������������������������������������������������
:sc_8
cls
::�޸�ע�������Զ�����档
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD  /d  1  /f
net stop SessionEnv 
net stop TermService /y
mshta vbscript:msgbox("Զ��Э���ѹر�",64,"��ʾ")(window.close) 
goto sc_999