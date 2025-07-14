#!/usr/bin/env bash
# check_compromised.sh – Quick Linux compromise triage tool
# Author: Farzan Afringan
# Description: This script performs a basic security audit on a potentially compromised Linux server.

# Create a log file with timestamp
LOG="compromise_report_$(date +%F_%H-%M-%S).txt"
exec > >(tee -a "$LOG") 2>&1

# Helper function to print section titles in bold
bold() {
  printf "\e[1m%s\e[0m\n" "$*"
}

bold "=== Active Login Sessions ==="
who
w

bold "=== Top Memory-Consuming Processes ==="
ps aux --sort=-%mem | head -20

bold "=== Listening Ports and Services ==="
ss -tulpn 2>/dev/null || netstat -tulpn

bold "=== Cron Jobs (System and User) ==="
for f in /etc/cron*; do ls -l "$f"; done
crontab -l 2>/dev/null || echo "No user crontab found"

bold "=== Recently Modified Files (Last 24h) ==="
find / -type f -mtime -1 2>/dev/null | head -20

bold "=== Non-System User Accounts (UID >= 1000) ==="
awk -F: '$3>=1000 {print $1 ":" $3 ":" $6}' /etc/passwd

bold "=== SSH Authorized Keys (for all users) ==="
awk -F: '$3>=1000 {print $1 ":" $6}' /etc/passwd | while IFS=: read -r user home; do
  key_file="$home/.ssh/authorized_keys"
  if [ -f "$key_file" ]; then
    echo "-- $user"
    cat "$key_file"
  fi
done

bold "=== Aliased Commands (Check for hijacking) ==="
alias

bold "=== Environment Variables (Check for LD_PRELOAD, PATH changes, etc.) ==="
env

bold "=== Report saved as $LOG ==="
