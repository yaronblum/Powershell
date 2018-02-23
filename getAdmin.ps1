set  params=^([2-9]|10)$
new-variable -name fileToRun
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "cmd.exe", "/c ""%1"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

Start-Proc\getadmin.vbs"
del "%temp%\getadmin.vbs"`