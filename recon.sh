#/bin/bash 

#---------------------------------------------
# Script to Automate The Intial Recon Phase
#---------------------------------------------

# Get IP Address 
read -p 'Enter the IP Address: ' IP
echo""

# Nmap Portion 
echo "-----------------------Basic Nmap Scan--------------------------"
nmap -A $IP -o nmap.txt 
echo""

echo "-----------------------Nmap Vuln Scan--------------------------"
nmap --script vuln $IP -o nmapvuln.txt
echo""

# Gobuster Portion 
echo "-----------------------Gobuster Scan--------------------------"
gobuster dir -u $IP -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -n -e -o dir.txt -x asp,bak,cgi,conf,csv,html,jpg,js,json,key,log,lst,php,png,sh,sql,tmp,txt,zip -t 30
echo ""
