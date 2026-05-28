#!/bin/bash

# Module 1

# Zoe Rochelle
# Programming for Security Professionals
# Professor Lang
# 05/27/2026

# source: The Linux Command Line - William Shotts

## ToDo ##
    # Create a second script to continuously monitor this server for-
    # activity by running the first script every half minute

## run commands ##
# chmod +x monitor_script.sh
# ./monitor_script.sh


echo "-- monitor script: start --"

seconds=30
count=0
# while true; do
while (( count < 20 )); do

    ## tell me when it starts
    echo "running logging script iteration $((count + 1)): $(date --iso-8601=seconds)"

    ## call the child script
    ./logging_script.sh

    ## wait 30 seconds
    sleep "$seconds"

    ((count++))
done

echo "-- monitor script: end --"
