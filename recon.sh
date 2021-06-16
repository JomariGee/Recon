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
	nmap --script vuln $IP -o nmapvuln.txt
	echo""

# Nikto Portion
	echo $Orange
	echo "----------------------- Nikto Scan --------------------------"
	echo $White
	nikto -h $IP -output nikto.txt


# Gobuster Portion 
	echo $Red
	echo "----------------------- Gobuster Scan --------------------------"
	echo $White
	gobuster dir -u $IP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -n -e -o dir.txt -x asp,bak,cgi,conf,csv,html,jpg,js,json,key,log,lst,php,png,sh,sql,tmp,txt,zip -t 30
	echo ""
