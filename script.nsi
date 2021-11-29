# an installer that updates the speechmatics license and docker license token of US Army EVAS PCs
# !include MUI2.nsh
Name "US Army Speechmatics Update"
RequestExecutionLevel admin
OutFile "army_spm_update.exe"
BrandingText "eVerbatim, Inc. 2021"
InstallDir "C:\eVerbatim\Updates\Update1"
Icon "favicon.ico"
# !define MUI_ICON "favicon.ico"
Section "Begin Install"
    messageBox MB_OKCANCEL|MB_ICONEXCLAMATION "WARNING: DO NOT INSTALL THIS UPDATE WITHOUT FIRST CONNECTING TO THE INTERNET AND FULLY CLOSING ECLIPSE. IF YOU ARE NOT CURRENTLY CONNECTED TO THE INTERNET PLEASE SELECT CANCEL AND CLOSE THE INSTALLER. OTHERWISE SELECT OK TO CONTINUE." IDOK true IDCANCEL false
    true:
    messageBox MB_OK "You are about to update EVAS. This will allow your system to continue to function. Select OK to continue with the installation."
    SetOutPath $INSTDIR
    File "Docker_Desktop_Installer.exe"
    File "army_data.csv"
    File "global.set"
    File "load_docker_image.bat"
    File "lic_update.ps1"
    messageBox MB_OK "The latest version of Docker is about to be installed. Please do not change any settings in the installation. If prompted click Continue or OK to move through the installation."
    nsExec::ExecToStack '"$INSTDIR\Docker_Desktop_Installer.exe"'
    messageBox MB_OK " Docker is now installed. Before clicking OK to continue you MUST start Docker Desktop by double clicking it's icon on the Desktop. You will have to agree to the new terms and conditions to continue."
    messageBox MB_OK "Once Docker is FULLY running please select OK to move on to the next step of the installation."
    ExecWait 'powershell -inputformat none -ExecutionPolicy RemoteSigned -File "$INSTDIR\lic_update.ps1" '
    Exec '"$INSTDIR\load_docker_image.bat"'
    messageBox MB_OK "EVAS update completed. Please continue with the remaining steps of the installation guide. If you have any questions or concerns please direct them to info@everbatim.net or call (410) 626-7866 (M-F 8:30 AM - 5:00 PM EST). Thank you for taking the time to install this necessary update."
    false:
    Goto +1
SectionEnd