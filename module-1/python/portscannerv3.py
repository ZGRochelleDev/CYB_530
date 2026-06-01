#!/usr/bin/env python
import socket
import subprocess
import sys
from datetime import datetime

# Clear the screen
subprocess.call('clear', shell=True)

# Ask to input an IP: like '127.0.0.1' (localhost)
remoteServer    = input("Enter a remote host to scan: ")
remoteServerIP  = socket.gethostbyname(remoteServer)

# Print a nice banner with information on which host we are about to scan
print ("-" * 60)
print ("Please wait, scanning remote host", remoteServerIP)
print ("-" * 60)

# Check what time the scan started: HH:MM:SS
t1 = datetime.now()

# Using the range function to specify ports (here it will scans all ports between 65535 and 1)
# We also put in some error handling for catching errors
try:
    for port in range(65535, 0, -1):   # changed from 1025

        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        result = sock.connect_ex((remoteServerIP, port))

        if result == 0:
            print ("Port {}: 	 Open".format(port) )

            try:
                service = socket.getservbyport(port)
                print(f"Service is = {service}")
            except Exception as e:
                print(f"Service is = UNK")

        sock.close()

except KeyboardInterrupt:
    print ("You pressed Ctrl+C")
    sys.exit()

# Get Address Info Error: if a hostname fails to resolve
except socket.gaierror:
    print ('Hostname could not be resolved. Exiting')
    sys.exit()

except socket.error as err:
    print ("Couldn't connect to server:", err)
    sys.exit()

# Checking the time again
t2 = datetime.now()

# Calculates the difference of time, to see how long it took to run the script
total =  t2 - t1

# Printing the information to screen
print ('Scanning Completed in: ', total)
