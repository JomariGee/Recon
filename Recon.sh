#!/bin/bash

#---------------------------------------------
# Combination Script of Dir.sh & Recon.sh
#---------------------------------------------

# Colors
	Red=$'\e[1;31m'
	Green=$'\e[1;32m'
	Orange=$'\e[1:33m'
	Blue=$'\e[1;34m'
	Purple=$'\e[1;35m'
	White=$'\e[0m'

# Get Directory Name 
	read -p 'Directory Name: ' Dir 
	echo""

# Make Directory 
	mkdir $Dir

# Move to Directory
	cd $Dir

# Create Markdown file 
	subl Notes.md -b

# Format the file
	echo 'Notes 
------------------------------------------------------ 
	Now 
		- 
		
	Noted 
		- 

	Credentials 
		- 

	' >> Notes.md

# Get IP Address 
	read -p 'Enter the IP Address: '$Green IP

# Send IP address to notes 
	echo IP Address: $IP >> Notes.md
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
	nmap -A $IP -p1-65535 -o nmap.txt 
	echo""

# Gobuster Portion 
	echo $Red
	echo "----------------------- Gobuster Scan --------------------------"
	echo $White
	gobuster dir -u $IP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -n -e -o dir.txt -x html,txt,php -t 80
	echo ""

	echo $Purple
	echo "----------------------- Nmap Vuln Scan --------------------------"
	echo $White
	nmap --script vuln $IP -oN Nmapvuln.txt
	echo""

 #Nikto Portion
	echo $Orange
	echo "----------------------- Nikto Scan --------------------------"
	echo $White
	nikto -h $IP -output nikto.txt
