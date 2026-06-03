## ToDo ##
# A PS script to run the 'netstat -a' command and print all of the 'IP Version 6' connections
# pipe the output from the 'netstat -a' command into the PowerShell 'select-string' cmdlet
#  - extract only the lines which match on "tcp6", "udp6" or "icm6"

## To Run ##
# Set-ExecutionPolicy RemoteSigned
# .\script_3.ps1

function Test-Netstat-3 {
    Write-Host " - Script 3: netstat"

    $establishedResults = netstat -a | Select-String -Pattern '^\s*(tcp6|udp6|icm6)\b'

    return $establishedResults

}
Write-Output (Test-Netstat-3)
