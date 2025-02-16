@echo off
setlocal

:: Set paths
set REPO_URL=https://github.com/dphelps526/CCNA
set INSTALL_DIR=C:\Users\%USERNAME%\Documents\CCNA
set DESKTOP=%USERPROFILE%\Desktop
set START_SCRIPT=%DESKTOP%\start_server.bat

:: Clone the repository
if not exist "%INSTALL_DIR%" (
    git clone %REPO_URL% "%INSTALL_DIR%"
) else (
    echo Repo already exists.
)

:: Create start_server.bat on the desktop
(
echo cd %INSTALL_DIR%
echo git pull
echo timeout 2 ^> NUL
echo start /b python -m http.server 80 --directory site
echo start /b http://localhost
echo echo "Keep this window open while using the site. Close and rerun this script if needed."
) > "%START_SCRIPT%"

echo Setup complete! Use "start_server.bat" on your desktop to run the server.
pause
