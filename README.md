# 🔍 Investigating a Compromised Linux Server

Practical companion repo for my Dev.to article **“How to Investigate a Compromised Linux Server”**.  
It provides a ready-to-run Bash script, sample outputs, and reference commands.

📖 **Read the full article:**  
<[https://dev.to/farzandev13](https://dev.to/farzandev13/-how-to-investigate-a-compromised-linux-server-1f78)>

---

## 🧰 What’s inside?

| File | Purpose |
|------|---------|
| `check_compromised.sh` | Automates the key investigation steps (users, processes, ports, cron, files, SSH keys). |
| `assets/sample-output.png` | Screenshot showing a typical run (add yours!). |

---

## 🚀 Quick start

```bash
git clone https://github.com/farzan-dev13/investigate-compromised-linux-server.git
cd investigate-compromised-linux-server
chmod +x check_compromised.sh
./check_compromised.sh
```

The script prints findings to the terminal and saves a log file in the same directory.


🔑 Key investigation commands (cheatsheet)


| Task                  | Command                      |
| --------------------- | ---------------------------- |
| Who is logged in?     | `who; w`                     |
| All running processes | `ps aux`                     |
| Listening ports       | `ss -tulpn`                  |
| Cron jobs             | `crontab -l; ls /etc/cron*`  |
| Files changed < 24 h  | `find / -mtime -1`           |
| SSH keys              | `cat ~/.ssh/authorized_keys` |


# This script does not make any changes to the system – it only collects and displays information.
# Compatible with most Linux distributions (Debian, Ubuntu, CentOS, AlmaLinux, and others).
# Intended for educational use, manual analysis, or quick triage of potentially compromised systems.





Made with ❤️ by Farzan Afringan


