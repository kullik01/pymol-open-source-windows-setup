::A* -------------------------------------------------------------------
::B* A simple wrapper script for running automation tasks more smoothly
::-* without needing to know the exact python interpreter path
::C* Copyright 2025 by Martin Urban.
::D* -------------------------------------------------------------------
::E* It is unlawful to modify or remove this copyright notice.
::F* -------------------------------------------------------------------
::G* Please see the accompanying LICENSE file for further information.
::H* -------------------------------------------------------------------
::I* Additional authors of this source file include:
::-*
::-*
::-*
::Z* -------------------------------------------------------------------
@echo off
:: Do NOT add any automation logic here! Please use the automations.py for that!

if "%1"=="init" (
    if exist .\.venv\Scripts\python.exe (
        echo Virtual environment already exists. Nothing to do.
        exit /b 0
    )

    :: Check if Python is available
    python --version >nul 2>&1
    if %errorlevel% neq 0 (
        echo Error: Python is not installed or not added to the PATH.
        exit /b 1
    )

    :: Create the virtual environment in .venv
    echo Creating virtual environment in .venv...
    python -m venv .venv
    if %errorlevel% neq 0 (
        echo Error: Failed to create the virtual environment.
        exit /b 1
    )

    echo Virtual environment created successfully in .venv.
    exit /b 0
)

if exist .\.venv\Scripts\python.exe (
    :: Default behavior: Run automations.py
    .\.venv\Scripts\python.exe .\automations.py %*
) else (
    echo Virtual environment does not exist yet! Please run run_automation.bat init
)
