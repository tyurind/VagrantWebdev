@echo off
SetLocal EnableExtensions EnableDelayedExpansion

cd "%~dp0\..\.."

FOR /F "Delims="  %%a IN (' vagrant status ^| findstr /R /O "poweroff" ') DO (
	::ECHO "1:  %%a"
	IF "%%a" NEQ "" (
		:: ECHO "  s OFF"
		GOTO VAGRANT_UP
	)
)
GOTO VAGRANT_SSH

:VAGRANT_UP
vagrant up


:VAGRANT_SSH
vagrant ssh %*