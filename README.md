# recon_tool_v1
A script to automate the recon process for penetration tests.
It automates domain and sub-domain enumertation.
It tests connectivity to identified subdomains using ping. and writes all findings to an output file.
It runs nmap against identified sub-domains to identify open ports and services.
It also runs nslookup.

Dependencies 
 - subfinder
   ``go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest``
- Go
