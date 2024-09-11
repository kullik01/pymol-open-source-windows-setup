; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
WizardImageFile=compiler:WizClassicImage.bmp
AppName=PyMOL-open-source
AppVersion=3.0.0
AppCopyright=Hannah Kullik, Martin Urban, Schrodinger LLC
AppId={{192F52C3-D86D-4735-9929-C7DF593CB534}
DefaultDirName={userappdata}\PyMOL-open-source
AppPublisher=Hannah Kullik
VersionInfoProductName=PyMOL-open-source
MinVersion=10.0.19045
OutputDir=out
OutputBaseFilename=pymol-3_0_0-bin-win64
; VersionInfoCopyright=GNU GPL-3.0
DisableDirPage=True
DisableProgramGroupPage=True
ArchitecturesInstallIn64BitMode=x64
WizardStyle=modern
DisableReadyPage=True
DisableFinishedPage=True
UninstallDisplayName=PyMOL-open-source
UninstallDisplayIcon={app}\assets\logo.ico
LicenseFile=LICENSE.txt
; This is necessary if the setup will exceed 2 GB
DiskSpanning=no
; DiskSliceSize=2100000000
PrivilegesRequired=none

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Dirs]
Name: "{userappdata}\PyMOL-open-source"
Name: "{userappdata}\PyMOL-open-source\bin"
Name: "{userappdata}\PyMOL-open-source\temp"

[Files]
Source: "..\c_sharp\PostInstallationRunner\bin\Release\net8.0\publish\win-x64\PostInstallationRunner.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "..\..\resources\python311\*"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs;
Source: "..\..\resources\Pmw-2.1.1.tar.gz"; DestDir: "{app}\temp"; Flags: ignoreversion recursesubdirs createallsubdirs;
Source: "..\..\resources\pymol-3.0.0-cp311-cp311-win_amd64.whl"; DestDir: "{app}\temp"; Flags: ignoreversion recursesubdirs createallsubdirs;
Source: "..\..\resources\VC_redist.x64.exe"; DestDir: "{app}\temp"; Flags: ignoreversion recursesubdirs createallsubdirs;
Source: "..\..\assets\logo.ico"; DestDir: "{app}\assets"; Flags: ignoreversion recursesubdirs createallsubdirs;

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]
var 
  tmpResultCode: Integer; 
  PostInstallFailed: Boolean;
  AppDataDir: string;
  PostInstallerExeFilepath: string;
  PymolExeFilepath: string;

procedure InitializeWizard;
begin
  // Initialize the global variable
  PostInstallFailed := False;
  // Retrieve the AppData directory path
  AppDataDir := ExpandConstant('{userappdata}');
  PostInstallerExeFilepath := AppDataDir + '\PyMOL-open-source\bin\PostInstallationRunner.exe'
  PymolExeFilepath := AppDataDir + '\PyMOL-open-source\bin\.venv\Scripts\pymol.exe'
end;

function DoPostInstallTasks: Boolean;
// Return True if successful, False if there was an error
begin
  try
    MsgBox('A post installation task needs to be run. This will take around 5 minutes to complete. Press OK to start.', mbInformation, MB_OK);
    if Exec(PostInstallerExeFilepath, '', '', SW_HIDE, ewWaitUntilTerminated, tmpResultCode) then // Runs PostInstallationRunner!!
    begin
      // Check the result code of the executed program
      if tmpResultCode <> 0 then
      begin
        // Return False to indicate failure
        Result := False;
      end
      else
      begin
        // Task succeeded
        Result := True;
      end;
    end
    else
    begin
      // Failed to execute the external program
      Result := False;
    end;
  except
    begin
      // Return False to indicate failure
      Result := False;
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  begin
    // Call a custom function to perform post-installation tasks
    if not DoPostInstallTasks then
    begin
      MsgBox('The installation failed due to a post-installation error.', mbError, MB_OK);
    end
    else
    begin
      MsgBox('The installation was successful. PyMOL will now start automatically.', mbInformation, MB_OK);
      Exec(PymolExeFilepath, '', '', SW_SHOW, ewNoWait, tmpResultCode)
    end;
  end;
end;
