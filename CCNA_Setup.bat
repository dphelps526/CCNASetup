@echo off
setlocal

:: Set paths
set REPO_URL=https://github.com/dphelps526/CCNA
set INSTALL_DIR=C:\Users\%USERNAME%\Documents\CCNA
set DESKTOP=%USERPROFILE%\Desktop
set START_SCRIPT=%DESKTOP%\start_server.bat

:: Check and install Git if missing
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Git...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri https://git-scm.com/download/win -OutFile git-installer.exe; Start-Process -Wait -FilePath .\git-installer.exe -ArgumentList '/SILENT'; del git-installer.exe}"
)

:: Check and install Python if missing
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo Installing Python...
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe -OutFile python-installer.exe; Start-Process -Wait -FilePath .\python-installer.exe -ArgumentList '/quiet InstallAllUsers=1 PrependPath=1'; del python-installer.exe}"
)

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
