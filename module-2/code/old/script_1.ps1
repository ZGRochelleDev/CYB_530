## ToDo ##
# Write a PS script to run the 'netstat -a' command
# then print all of the 'ESTABLISHED' sessions
#  - use the 'select-string' Powershell function to select only the lines containing "ESTABLISHED"

## To Run ##
# Set-ExecutionPolicy RemoteSigned
# .\script_1.ps1

## use Verb-Noun style for naming funcions
function Test-Netstat {
    Write-Host " - Script 1: netstat"

    ## The Select-String cmdlet is case insensitive, so it'll grab the headers w/o '-CaseSensitive'
    $establishedResults = netstat -a | Select-String "ESTABLISHED" -CaseSensitive

    return $establishedResults

}
Write-Output (Test-Netstat)
