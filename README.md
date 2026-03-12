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
- Go
