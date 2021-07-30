#/bin/bash

#---------------------------------------------
# Script to Automate The Intial Recon Phase
#---------------------------------------------

# Colors
	Red=$'\e[1;31m'
	Green=$'\e[1;32m'
	Orange=$'\e[1:33m'
	Blue=$'\e[1;34m'
	Purple=$'\e[1;35m'
	White=$'\e[0m'

# Get IP Address 
	read -p 'Enter the IP Address: '$Green IP
	echo"" $Blue

# Artwork
	echo '
     /  /\         /  /\         /  /\         /  /\         /  /\    
    /  /::\       /  /::\       /  /::\       /  /::\       /  /::|   
   /  /:/\:\     /  /:/\:\     /  /:/\:\     /  /:/\:\     /  /:|:|   
  /  /::\ \:\   /  /::\ \:\   /  /:/  \:\   /  /:/  \:\   /  /:/|:|__ 
 /__/:/\:\_\:\ /__/:/\:\ \:\ /__/:/ \  \:\ /__/:/ \__\:\ /__/:/ |:| /\
 \__\/~|::\/:/ \  \:\ \:\_\/ \  \:\  \__\/ \  \:\ /  /:/ \__\/  |:|/:/
    |  |:|::/   \  \:\ \:\    \  \:\        \  \:\  /:/      |  |:/:/ 
    |  |:|\/     \  \:\_\/     \  \:\        \  \:\/:/       |__|::/  
    |__|:|~       \  \:\        \  \:\        \  \::/        /__/:/   
     \__\|         \__\/         \__\/         \__\/         \__\/    
	'

# Nmap Portion 
	echo $Purple
	echo "----------------------- Basic Nmap Scan --------------------------"
	echo $White
	nmap -A $IP -o nmap.txt 
	echo""

	echo $Purple
	echo "----------------------- Nmap Vuln Scan --------------------------"
	echo $White
	nmap --script vuln $IP -oN Nmapvuln.txt
	echo""
# FFUF Portion 
	echo $Red
	echo "----------------------- FFUF Scan --------------------------"
	echo $White
	ffuf -c -w ~/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt -u http://$IP/FUZZ -recursion -r -t 50 -o ffuf
	echo ""

# Nikto Portion
	echo $Orange
	echo "----------------------- Nikto Scan --------------------------"
	echo $White
	nikto -h $IP -output nikto.txt
