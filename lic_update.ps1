# Unique Bits: CSV doc name, global.set, generic license name, drive folder ID

# get current pc serial
$SerialNumber = (Get-WmiObject win32_bios).SerialNumber

# hashtable with spm licenses
$Data = @{}
$CSV = $PSScriptRoot + "\army_data.csv"
Import-Csv $CSV | ForEach-Object { $Data.add($_.SN, $_.ID) }
# set file locations
$FileIn = $PSScriptRoot + "\global.set"
$FileOut = $Home + "\Documents\Eclipse\"
$SubFolders = Get-ChildItem -Directory $FileOut

# define log
$Date = Get-Date
$SubFolderLog = "global.set file placed in the following folders: " + $SubFolders

# email validator
$Email = Read-Host "Please type your email and press enter"
$Email2 = Read-Host "Please enter your email again"

while ($Email -ne $Email2) {
    Write-Host "Emails do not match"
    $Email = Read-Host "Please type your email and press enter"
    $Email2 = Read-Host "Please enter your email again"
        
    if ($Email -ne $Email2) {}
    else {
        $Email = $Email2
        Write-Host "Email confirmed. Thank you."
        Write-Host "Exiting..."
        Start-Sleep -Seconds 1.5
        break
    }
}

$Rank = Read-Host "Please enter your Rank or N/A if none"
$FirstName = Read-Host "Please enter your First Name"
$LastName = Read-Host "Please enter your Last Name"

function Log {
    Write-Host $LogString1
    Write-Host $LogString2
    Add-Content -path $LogFile -Value $Date
    Add-Content -path $LogFile -Value $Email
    Add-Content -path $LogFile -Value $Rank
    Add-Content -path $LogFile -Value $FirstName
    Add-Content -path $LogFile -Value $LastName
    Add-Content -path $LogFile -Value $LogString1
    Add-Content -path $LogFile -Value $LogString2
    Add-Content -path $LogFile -Value $SubFolderLog
    Add-Content -path $LogFile -Value "`n"
}

# define license that will be written to global.set file based on serial
# write to log file based on result
if ($Data.ContainsKey($SerialNumber)) {
    $License = $Data.$SerialNumber
    $LogString1 = "SUCCESS: Match Found For Serial " + $SerialNumber
    $LogString2 = "Speechmatics License Updated to " + $License
    $LogFile = $Home + "\Documents\Eclipse\" + "SUCCESS_" + $SerialNumber + ".log"
    $ServerLogFileName = "SUCCESS_" + $SerialNumber + ".log"
    Log
}
else {
    $License = "ARMY-T1"
    $LogString1 = "FAILURE: No Match Found For Serial " + $SerialNumber
    $LogString2 = "Speechmatics License Remains " + $License
    $LogFile = $Home + "\Documents\Eclipse\" + "FAILURE_" + $SerialNumber + ".log"
    $ServerLogFileName = "FAILURE_" + $SerialNumber + ".log"
    Log
}

# select line to overwrite, pass in license, overwrite then copy to every subdirectory in \documents\eclipse
$Line = Get-Content -path $FileIn | Select-String SpeechmaticsLicense= | Select-Object -ExpandProperty Line
$NewLine = "SpeechmaticsLicense=" + $License
$Content = Get-Content -path $FileIn
$Content | ForEach-Object {$_ -replace $Line, $NewLine} | Set-Content -path $FileIn
foreach ($SubFolders in $SubFolders.name) {
Copy-Item -Path $FileIn -Destination "$FileOut\$SubFolders" -Recurse
}

#######################################################################################################################################
# Begin log file upload code
#######################################################################################################################################

$Destination = "ftp://ftp.everbatim.net/military_logs/army/" + $ServerLogFileName
$client = New-Object System.Net.WebClient
$client.Credentials =
    New-Object System.Net.NetworkCredential("everbati", "puy.FQZ6zhw5njn3kpu")
$client.UploadFile(
    $Destination, $LogFile)