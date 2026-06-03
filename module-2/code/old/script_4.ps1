## ToDo ##
# Run the PowerShell cmdlet Get-Process to get information on all of the running processes on the system
# Then pipe the output into the 'select-string' cmdlet to extract only the lines which match on the 'root' user
#  - use the option to have a column with the 'username' of the user running the process

## To Run ##
# Set-ExecutionPolicy RemoteSigned
# .\script_4.ps1


function Test-GetProcess {
    Write-Host " - Script 4: Get-Process"

    # 'Out-String' converts output into strings
    # The '-Stream' is needed to print 1 line at a time, or else it'll just print 1 big string
    $establishedResults = Get-Process -IncludeUserName | Out-String -Stream | Select-String -Pattern 'root'

    return $establishedResults

}

Write-Output (Test-GetProcess)
