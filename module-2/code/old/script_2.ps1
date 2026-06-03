## ToDo ##
# Write a PS script to run the 'netstat -a' command and print all of the 'IP Version 4' connections
# Then pipe the output into the PowerShell 'select-string' cmdlet
#  - extract only the lines which match on "tcp4", "udp4" or "icm4"

## To Run ##
# Set-ExecutionPolicy RemoteSigned
# .\script_2.ps1

function Test-Netstat {
    Write-Host " - Script 2: netstat"

    # \b in the regex, is called word-boundary
    $establishedResults = netstat -a | Select-String -Pattern '^\s*(tcp|udp|icmp)\b'

    return $establishedResults

}

Write-Output (Test-Netstat)
