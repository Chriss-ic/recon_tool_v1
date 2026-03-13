# recon_tool_v1
A script to automate the recon process for penetration tests.
It automates domain and sub-domain enumertation using subfinder.
It tests connectivity to identified subdomains using ping.
It runs nmap against identified sub-domains to identify open ports and services.
It also runs nslookup.
Writes all findings to an output file.

Dependencies 
 - subfinder
   ``go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest``
- assetfinder
  ``sudo apt install assetfinder``
- Go

How to run:
- Fork or download the script
- Modify the file permissions
- run the script and provide the target domain when prompted.
- Leave the rest to Chakra
