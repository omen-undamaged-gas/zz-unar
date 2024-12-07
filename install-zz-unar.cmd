@echo off
rem white-black
color f0
set sendto="%AppData%\Microsoft\Windows\SendTo"

echo Copy zz-unar files to %sendto%
@pushd %~dp0
copy zz-unar* %sendto% /-Y
@popd

echo.
pause
