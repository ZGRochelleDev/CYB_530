#!/bin/bash

# Module 2

# Zoe Rochelle
# Programming for Security Professionals
# Professor Lang
# 06/02/2026

## ToDo ##
    # Task 1
    # Write a PS script to run the 'netstat -a' command
    # then print all of the 'ESTABLISHED' sessions
    #  - use the 'select-string' Powershell function to select only the lines containing "ESTABLISHED"

    # Task 2
    # Write a PS script to run the 'netstat -a' command and print all of the 'IP Version 4' connections
    # Then pipe the output into the PowerShell 'select-string' cmdlet
    #  - extract only the lines which match on "tcp4", "udp4" or "icm4"

    # Task 3
    # A PS script to run the 'netstat -a' command and print all of the 'IP Version 6' connections
    # pipe the output from the 'netstat -a' command into the PowerShell 'select-string' cmdlet
    #  - extract only the lines which match on "tcp6", "udp6" or "icm6"

    # Task 4
    # Run the PowerShell cmdlet Get-Process to get information on all of the running processes on the system
    # Then pipe the output into the 'select-string' cmdlet to extract only the lines which match on the 'root' user
    #  - use the option to have a column with the 'username' of the user running the process



# I thought it would be a good idea to merge the 3 similar tasks into 1 function
# Task 4 was too different and I left it seperate
function Test-Sys-Activity {
    param (
        [string]$Status,
        [string]$Pattern,
        [switch]$CaseSensitive
    )

    Write-Host $Status

    if ($CaseSensitive) {
        $results = netstat -a | Select-String -Pattern $Pattern -CaseSensitive
    }
    else {
        $results = netstat -a | Select-String -Pattern $Pattern
    }

    return $results
}

## a list of commands to pass into the function
$commandList = @(
    @{
        Status = " - Script 1: netstat"
        Pattern = "ESTABLISHED"
        CaseSensitive = $true
    },
    @{
        Status = " - Script 2: netstat"
        Pattern = '^\s*(tcp|udp|icmp)\b'
        CaseSensitive = $false
    },
    @{
        Status = " - Script 3: netstat"
        Pattern = '^\s*(tcp6|udp6|icm6)\b'
        CaseSensitive = $false
    }
)

## iterate through each command
# - the backticks let you write cmds on seperate lines
foreach ($cmd in $commandList) {
    Test-Sys-Activity `
        -Status $cmd.Status `
        -Pattern $cmd.Pattern `
        -CaseSensitive:$cmd.CaseSensitive
}

## Task 4
function Test-GetProcess {
    Write-Host " - Script 4: Get-Process"

    # 'Out-String' converts output into strings
    # the '-Stream' is needed to print 1 line at a time, or else it'll just print 1 big string
    # the regex will now match: whitespace + 'root' + whitespace; better than just using: -Pattern 'root'

    $establishedResults = Get-Process -IncludeUserName | Out-String -Stream | Select-String -Pattern '\sroot\s'

    Write-Output ($establishedResults)

}

(Test-GetProcess)

## Run with:
# Set-ExecutionPolicy RemoteSigned
# .\script_combined.ps1
