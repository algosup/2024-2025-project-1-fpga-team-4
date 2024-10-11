@echo off
setlocal

:: Function to check if a program is installed
:check_program
where %1 >nul 2>nul
if %errorlevel% neq 0 (
    echo %1 is not installed. Installing...
    call :install_%1
) else (
    echo %1 is already installed.
)
exit /b

:: Function to install Python
:install_python
:: Check if Python is installed via the Microsoft Store
if not exist "%LocalAppData%\Microsoft\WindowsApps\python.exe" (
    echo Downloading and installing Python...
    start https://www.python.org/downloads/
    echo Please install Python 3.10 or higher and ensure "Add Python to PATH" is selected.
    exit /b
)
exit /b

:: Function to install Git
:install_git
echo Downloading and installing Git...
start https://git-scm.com/download/win
echo Please install Git and follow the prompts.
exit /b

:: Function to install Apio
:install_apio
echo Installing Apio...
pip install --user -U apio
if %errorlevel% neq 0 (
    echo Failed to install Apio. Make sure pip is working correctly.
    exit /b
)
exit /b

:: Check for Python
call :check_program python

:: Check for Git
call :check_program git

:: Check for pip
where pip >nul 2>nul
if %errorlevel% neq 0 (
    echo pip is not installed. Installing pip...
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py --user
    if %errorlevel% neq 0 (
        echo Failed to install pip. Please try manually.
        exit /b
    )
    del get-pip.py
)

:: Upgrade pip to the latest version
echo Upgrading pip...
python -m pip install --upgrade pip
if %errorlevel% neq 0 (
    echo Failed to upgrade pip. Please try manually.
    exit /b
)

:: Check for Apio
call :check_program apio

:: Clone the GitHub repository if not already cloned
set REPO_URL=https://github.com/algosup/2024-2025-project-1-fpga-team-4
set REPO_DIR=2024-2025-project-1-fpga-team-4

if not exist "%REPO_DIR%" (
    echo Cloning the GitHub repository...
    git clone --branch MinimumRequirement %REPO_URL%
    if %errorlevel% neq 0 (
        echo Failed to clone the repository.
        exit /b
    )
) else (
    echo Repository already cloned.
)

:: Navigate to the project directory
cd "%REPO_DIR%\src" || (echo Failed to navigate to the project directory. & exit /b)

:: Check if apio.ini exists; if not, initialize it
if not exist "apio.ini" (
    echo Creating apio.ini file with the specified board.
    apio init -b go-board
    if %errorlevel% neq 0 (
        echo Failed to create apio.ini. Please check the board name and try again.
        exit /b
    )
)

:: Upload the code to the Go Board
echo Uploading code to the Go Board...
apio upload
if %errorlevel% neq 0 (
    echo Upload failed. Make sure the FPGA board is connected and try again.
    exit /b
)

echo Upload completed successfully. Please connect the VGA cable and power the board.
