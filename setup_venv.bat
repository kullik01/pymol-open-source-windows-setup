@echo off
:: Check if Python is available
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Python is not installed or not added to the PATH.
    exit /b 1
)

:: Get Python version
for /f "tokens=2 delims= " %%v in ('python --version') do set PYTHON_VERSION=%%v
for /f "tokens=1,2 delims=." %%a in ("%PYTHON_VERSION%") do (
    set MAJOR=%%a
    set MINOR=%%b
)

:: Check if Python version is 3.11 or newer
if %MAJOR% lss 3 (
    echo Error: Python 3.11 or newer is required. Detected version: %PYTHON_VERSION%.
    exit /b 1
) else if %MAJOR%==3 if %MINOR% lss 11 (
    echo Error: Python 3.11 or newer is required. Detected version: %PYTHON_VERSION%.
    exit /b 1
)

:: Create the virtual environment in .venv
echo Creating virtual environment in .venv...
python -m venv .venv
if %errorlevel% neq 0 (
    echo Error: Failed to create the virtual environment.
    exit /b 1
)
.\.venv\Scripts\pip.exe install -r .\requirements.txt

echo Virtual environment created successfully in .venv.
exit /b 0
