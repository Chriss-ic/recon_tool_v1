#!/bin/bash

set -e 

echo "============================"
echo "          CHAKRA            "
echo "============================"

echo "Chakra is a tool to automate subdomain scans with subfinder and assetfinder"

read -p "Enter the target domain: " domain

timestamp=$(date +%F_%H-%M)
output_dir="recon_$domain_$timestamp"

mkdir -p $output_dir@$domain

#subfinder
echo "[+] Running subfinder..."

subfinder -d $domain -silent > $output_dir@$domain/subfinder.txt 

#asserfinder
echo "[+] Running Assetfinder..."
assetfinder --subs-only $domain >> $output_dir@$domain/assetfinder.txt

wait

echo "[+] Combining results..."

cat $output_dir@$domain/*.txt | sort -u > $output_dir@$domain/all_subdomains.txt

echo "[???] Total subdomains found: " 
wc -l $output_dir@$domain/all_subdomains.txt

# ------------------------------------
#        Parallel Scanning
# ------------------------------------

echo "[+] Starting Parallel scans..."

while read sub; do
  (
  echo "[+] Scanning $sub"

  ping -c 4 $sub > $output_dir@$domain/ping_$sub.txt 2>/dev/null

  nslookup $sub > $output_dir@$domain/dns_$sub.txt 2>/dev/null

  nmap -F $sub > $output_dir@$domain/nmap_$sub.txt 2>/dev/null

)&

done < $output_dir@$domain/all_subdomains.txt

wait

echo "-------------------------------"
echo "     RECON SCAN COMPLETE       "
echo "-------------------------------"

echo "Results saved to: $output_dir@$domain"
stty echo

