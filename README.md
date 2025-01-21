# Open-Source PyMOL setup (Unofficial Windows Setup)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.14698412.svg)](https://doi.org/10.5281/zenodo.14698412)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-blue.svg)](https://GitHub.com/kullik01/PyMOL-open-source-setup/graphs/commit-activity)
[![GitHub issues](https://img.shields.io/github/issues/kullik01/PyMOL-open-source-setup)](https://github.com/kullik01/PyMOL-open-source-setup/issues)
[![GitHub release](https://img.shields.io/github/release/kullik01/PyMOL-open-source-setup)](https://github.com/kullik01/PyMOL-open-source-setup/releases)

## <img src='https://github.com/primer/octicons/blob/main/icons/download-24.svg' width='32'/> [Quick Installation](https://github.com/kullik01/PyMOL-open-source-setup/wiki/Installation-for-Windows-Operating-System)
## Contents of this document
* [Description](#Description)
* [Contents of this repository](#Contents-of-this-repository)
  * [Sources](#Sources)
  * [Assets](#Assets)
* [Installation for Windows OS](#Installation-for-Windows-OS)
    * [Source code](#Source-code)
* [References and useful links](#References-and-useful-links)
* [Acknowledgements](#Acknowledgements)

## Description
PyMOL-open-source-setup is an open project which provides an easy-to-use installation setup for the open-source version of PyMOL.
[PyMOL(tm)](https://pymol.org/) is a software tool for visualizing and analyzing molecular structures such as proteins, nucleic acids, and small molecules in 3D. PyMOL is a trademark of Schrodinger, LLC. 
This repository focuses on simplifying the setup process for open-source PyMOL on the Windows operating system. 
The installation process does not involve the manual configuration of a Python/conda environment, thus facilitating a rapid and straightforward installation.
This allows a broader audience to start using the open-source version of PyMOL for research, teaching, or personal use.

The provided files and setup are unofficial (meaning: informal, no warranty, no liability, provided "as is", no connection to Schrodinger LLC).

## Contents of this repository
### Sources
There are two different languages used in this repository for the setup functionality.

- _inno_setup_
  - <a href="https://github.com/kullik01/PyMOL-open-source-setup/blob/main/src/inno_setup/LICENSE.txt">LICENSE.txt</a> file: Contains the license information for PyMOL and this repository.
  - <a href="https://github.com/kullik01/PyMOL-open-source-setup/blob/main/src/inno_setup/setup.iss">setup.iss</a> file: Script file used for the installation setup of the PyMOL-open-source-setup. 

### Assets
There are two different directories used for images.

- <a href="https://github.com/kullik01/PyMOL-open-source-setup/tree/main/assets">assets</a> directory
  - <a href="https://github.com/kullik01/PyMOL-open-source-setup/tree/main/assets/convert_to_ico">convert_to_ico</a> directory: Contains a batch script,
which converts the logo.png image into various resolutions (from 16x16 to 256x256) PNG files and a multi-resolution ICO file.
Moreover, the directory includes individual PNG files for each resolution, a generated logo.ico file, and the original logo.png.
  - <a href="https://github.com/kullik01/PyMOL-open-source-setup/tree/main/assets/raw">raw</a> directory: Includes the logo in its original vector format as an SVG file.
  - <a href="https://github.com/kullik01/PyMOL-open-source-setup/tree/main/assets/wiki_images">wiki_images</a> directory: Contains images for wiki.

## Installation for Windows OS
### Pre-built binary
PyMOL-open-source-setup is tested and available for Windows 10 and 11.
To be able to run PyMOL, the **[Microsoft Visual C++ Redistributable packages for Visual Studio 2022](https://learn.microsoft.com/en-US/cpp/windows/latest-supported-vc-redist?view=msvc-170)** are **required**.
The installation of these packages will be carried out during the installation process.

For a convenient and user-friendly installation click [here](https://github.com/kullik01/PyMOL-open-source-setup/wiki/Installation-for-Windows-Operating-System).

### Source code
#### Prerequisites:
- Inno Setup compiler version 6
  - Installed in `C:\Program Files (x86)\Inno Setup 6\ISCC.exe`!

#### Prerequisites (if PyMOL should be built from source):
- MSBuild
  - Part of [VS 2022](https://visualstudio.microsoft.com/vs/) (incl. Community edition)
- CMake
  - To download the MSI installer click [here](https://github.com/Kitware/CMake/releases/download/v3.31.4/cmake-3.31.4-windows-x86_64.msi)
  - To download the portable version click [here](https://github.com/Kitware/CMake/releases/download/v3.31.4/cmake-3.31.4-windows-x86_64.zip)
  - **Be aware**: Add the cmake.exe to your PATH variable ([short guide](https://learn.microsoft.com/en-us/previous-versions/office/developer/sharepoint-2010/ee537574(v=office.14))). Check by running `cmake --version`

To modify the source code, download or clone the repository.
The Inno Setup script may then be altered by opening the relevant file, setup.iss, in a text editor of your choice. 

To reproduce the setup, use the `taskfile.yaml` file with the following commands:
```powershell
.\setup_venv.bat
.\venv\Scripts\python.exe .\run_automation.py setup-dev-env
.\venv\Scripts\python.exe .\run_automation.py build-setup-exe
```


## References and useful links
**PyMOL**
* [Open-source GitHub repository](https://github.com/schrodinger/pymol-open-source)
* [Incentive PyMOL](https://pymol.org/)
* [Unofficial PyMOL Windows Build (Binary Wheel)](https://github.com/urban233/pymol-open-source-windows-build)

## Acknowledgements
**Developer:**
* Hannah Kullik

**End-user tester:**
* Martin Urban

**I would like to thank the communities behind the open software libraries, Martin Urban for end-user testing as well as for providing files needed to make the PyMOL installation comfortable (and without the hassle of compling PyMOL from source) and especially Warren L. DeLano for their amazing work.**
