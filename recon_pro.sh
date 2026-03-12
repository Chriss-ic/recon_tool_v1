#!/bin/bash

set -e 

echo "============================"
echo "          CHAKRA            "
echo "============================"

echo "Chakra is a tool to automate subdomain scans with subfinder and assetfinder"

read -p "Enter the target domain: " domain

timestamp=$(date +%F_%H-%M)
output_dir="recon_$domain_$timestamp"

mkdir -p $output_dir

#subfinder
echo "[+] Running subfinder..."

subfinder -d $domain -silent > $output_dir/all_subdomains.txt 

echo "[???] Total subdomains found: "
wc -l $output_dir/all_subdomains.txt

# ------------------------------------
#        Parallel Scanning
# ------------------------------------

echo "[+] Starting Parallel scans..."

while read sub; do
  (
  echo "[+] Scanning $sub"

  ping -c 4 $sub > $output_dir/ping_$sub.txt 2>/dev/null

  nslookup $sub > $output_dir/dns_$sub.txt 2>/dev/null

  nmap -F $sub > $output_dir/nmap_$sub.txt 2>/dev/null

)&

done < $output_dir/all_subdomains.txt

wait

echo "-------------------------------"
echo "     RECON SCAN COMPLETE       "
echo "-------------------------------"

echo "Results saved to: $output_dir"


