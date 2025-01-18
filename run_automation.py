"""
#A* -------------------------------------------------------------------
#B* This file contains source code for running automation tasks related
#-* to the build process of the PyMOL computer program
#C* Copyright 2025 by Martin Urban.
#D* -------------------------------------------------------------------
#E* It is unlawful to modify or remove this copyright notice.
#F* -------------------------------------------------------------------
#G* Please see the accompanying LICENSE file for further information.
#H* -------------------------------------------------------------------
#I* Additional authors of this source file include:
#-*
#-*
#-*
#Z* -------------------------------------------------------------------
"""
import argparse
import pathlib
import subprocess
import shutil
import sys

# pyproject_toml = toml.load("pyproject.toml")
# PROJECT_NAME = pyproject_toml["project"]["name"]
# PROJECT_VERSION = pyproject_toml["project"]["version"]

PROJECT_ROOT_DIR = pathlib.Path(__file__).parent

PYTHON_EXECUTABLE = sys.executable  # This gives the current Python executable
DEBUG = True


# <editor-fold desc="Automation classes">
class BuildInnoSetup:
  """Contains the logic for building the inno setup EXE file."""

  def __init__(self) -> None:
    """Constructor."""
    self.inno_build_path = pathlib.Path(PROJECT_ROOT_DIR / "innoBuild")
    self.inno_build_src_path = pathlib.Path(self.inno_build_path / "inno-sources")
    self.inno_build_assets_path = pathlib.Path(self.inno_build_path / "inno-assets")
    self.inno_setup_compiler_filepath = pathlib.Path(r"C:\Program Files (x86)\Inno Setup 6\ISCC.exe")
    self.inno_setup_script_filepath = pathlib.Path(PROJECT_ROOT_DIR / "src/inno_setup" / "setup.iss")

  def setup_build_environment(self) -> None:
    """Sets up a temporary build environment."""
    # <editor-fold desc="Path/Filepath definitions">
    tmp_pymol_win_run_automation_filepath = pathlib.Path(PROJECT_ROOT_DIR / "vendor/pymol-open-source-windows-build/run_automation.py")
    tmp_pymol_win_build_files_path = pathlib.Path(PROJECT_ROOT_DIR / "vendor/pymol-open-source-windows-build/dist/exe.win-amd64-3.11")
    tmp_pymol_win_build_logo_filepath = pathlib.Path(PROJECT_ROOT_DIR / "vendor/pymol-open-source-windows-build/alternative_design" / "logo.ico")
    tmp_vc_redist_setup_filepath = pathlib.Path(PROJECT_ROOT_DIR / "vendor/microsoft" / "VC_redist.x64.exe")
    # </editor-fold>
    print(subprocess.run(
      [PYTHON_EXECUTABLE, tmp_pymol_win_run_automation_filepath, "build-win-exe"],
      stdout=sys.stdout, stderr=sys.stderr, text=True
    ))
    # <editor-fold desc="Copy operations">
    if self.inno_build_path.exists():
      shutil.rmtree(self.inno_build_path)
      self.inno_build_path.mkdir()
    shutil.copytree(tmp_pymol_win_build_files_path, self.inno_build_src_path, dirs_exist_ok=True)
    shutil.copy(tmp_vc_redist_setup_filepath, self.inno_build_src_path)
    if not self.inno_build_assets_path.exists():
      self.inno_build_assets_path.mkdir()
    shutil.copy(tmp_pymol_win_build_logo_filepath, pathlib.Path(self.inno_build_assets_path / "logo.ico"))
    # </editor-fold>

  def build(self) -> None:
    """Builds the PyMOL Windows EXE file."""
    self.setup_build_environment()
    subprocess.run(
      [self.inno_setup_compiler_filepath, self.inno_setup_script_filepath],
      stdout=sys.stdout, stderr=sys.stderr, text=True
    )
    # <editor-fold desc="Clean up">
    if not DEBUG:
      shutil.rmtree(self.inno_build_path)
    # </editor-fold>
# </editor-fold>


# <editor-fold desc="Automation functions">
def setup_dev_env() -> None:
  """Installs the dependencies needed for building the _cmd extension module."""
  subprocess.run(["git", "clone", "https://github.com/urban233/pymol-open-source-windows-build", pathlib.Path("./vendor/pymol-open-source-windows-build")])
  subprocess.run(["powershell.exe", "pwd"], cwd=str(pathlib.Path(PROJECT_ROOT_DIR / 'vendor/pymol-open-source-windows-build'))
  )
  subprocess.run(
    [
      "cmd.exe", "/c", str(pathlib.Path(r'.\setup_dev_env.bat'))
    ],
    cwd=pathlib.Path(PROJECT_ROOT_DIR / 'vendor/pymol-open-source-windows-build')
  )
  subprocess.run(
    [
      pathlib.Path(PROJECT_ROOT_DIR / "vendor/pymol-open-source-windows-build/.venv/Scripts" / "python.exe"),
      pathlib.Path(PROJECT_ROOT_DIR / "vendor/pymol-open-source-windows-build" / "run_automation.py"), 'setup-dev-env'
    ], cwd=pathlib.Path(PROJECT_ROOT_DIR / "vendor/pymol-open-source-windows-build")
  )


def build_setup_exe() -> None:
  """Builds the inno setup EXE file."""
  tmp_builder = BuildInnoSetup()
  tmp_builder.build()
# </editor-fold>


def main() -> None:
  """Main function."""
  parser = argparse.ArgumentParser(description="Automation script with subcommands.")
  # <editor-fold desc="Subparsers">
  subparsers = parser.add_subparsers(dest='command')
  install_parser = subparsers.add_parser('setup-dev-env', help="Installs build dependencies.")
  install_parser.set_defaults(func=setup_dev_env)
  build_setup_exe_parser = subparsers.add_parser('build-setup-exe', help="Builds the inno setup EXE file.")
  build_setup_exe_parser.set_defaults(func=build_setup_exe)
  # </editor-fold>
  args = parser.parse_args()

  if args.command:
    args.func()


if __name__ == "__main__":
  main()
