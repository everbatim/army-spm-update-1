# army-spm-update-1
An installer that updates eclipse and docker settings
In order to recompile an installer do the following:
1.  Download the contents of this repo into a single directory on your computer
2.  Download a copy of the docker desktop installer and make sure its named or rename it to "Docker_Desktop_Installer.exe"
3.  Put this docker installer in the same directory as the rest of the files
4.  Change any relevent settings in the global.set file as you see fit or place a new global.set file if the customer has entirely seperate files (USMC, etc.)
5.  Update the army_data.csv file if newer data is available but maintain the formatting present in the current file
6.  Change any references in the powershell (ps1) script to the army if this installer is for a different customer
7.  Create a new directory on our file server alongside the everbatim.net/military_logs/army/ folder, for example everbatim.net/military_logs/usmc/
8.  This folder is where the log files will be sent during the installation
9.  Change the file path in the ps1 script to the newly created folder (line 88)
10. Change any language in the nsi script that is relevent to the new customer. This could be the OutFiles name, message language, included files, the favicon, etc.
11. Right-Click the NSI script and choose compile. As long as the compiler finishes with no errors feel free to run it.
