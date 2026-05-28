#!/bin/bash

# Module 1

# Zoe Rochelle
# Programming for Security Professionals
# Professor Lang
# 05/27/2026

# source: The Linux Command Line - William Shotts

## ToDo ##
    # Create a shell script to run the following commands:
    #   1. 'netstat -a',
    #   2. 'last'
    #   3. 'ps -elf'
    # output the response to a text file called 'snapshot'

## run commands ##
# chmod +x logging_script.sh
# ./logging_script.sh


get_timestamp() {
    date --iso-8601=seconds
}


# terminal commands can contain line breaks or quote characters that break the JSON
# using jq 
json_string() {
    jq -Rn --arg value "$1" '$value'
}


# JSON safe string for logging
data_formatter() {
    local cmd="$1"
    bash -c "$cmd" 2>&1 | jq -Rs .

    # 2>&1
    # combines the output stream and error stream so that,
    # if the command fails, the error message will get captured and logged
    # source: https://stackoverflow.com/questions/16497317/piping-both-stdout-and-stderr-in-bash

    # | jq
    # pipes the command output into jq

    # -R
    # read raw text instead of expecting JSON input

    # -s
    # concat all input into a single string, not line by line

    # .
    # the dot means: print this value
}


# 1 = filename, 2 = command
write_to_file () {

    local log_dir="log_output"
    local file="$log_dir/$1"
    local cmd="$2"

    mkdir -p "$log_dir"

    echo " - writing to file: $file"

    #   >    overwrites
    #   >>   appends

    ## printf and formatting output: page 324
    printf '{"timestamp":"%s","command":%s,"output":%s}\n' \
        "$(get_timestamp)" \
        "$(json_string "$cmd")" \
        "$(data_formatter "$cmd")" >> "$file"

}


main () {

    LOG_FILE="system_log.jsonl"

    ## arrays: page 495
    cmd_arr=("netstat -a" "last" "ps -elf")

    ## loops with for: page 466
    for cmd in "${cmd_arr[@]}"; do
        echo " - running: $cmd"
        write_to_file "$LOG_FILE" "$cmd"
    done

}

main
