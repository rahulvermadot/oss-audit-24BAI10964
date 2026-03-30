# oss-audit-24BAI10964

## The Open Source Audit — Python
**Course:** Open Source Software (OSS NGMC)
**Student:** Rahul Rajkumar Verma | **Registration No.:** 24BAI10964
**Software Audited:** Python Programming Language (PSF License)

---

## About This Project

This repository contains the complete submission for the OSS NGMC Capstone Project — *The Open Source Audit*. The project audits **Python**, one of the most widely used open-source programming languages in the world, across five dimensions: origin & philosophy, Linux footprint, FOSS ecosystem, comparison with proprietary alternatives, and practical shell scripting.

---

## Repository Structure

```
oss-audit-24BAI10964/
├── README.md                          ← You are here
├── report/
│   └── OSS_Audit_Python_Report.pdf   ← Full 12–16 page project report
└── scripts/
    ├── script1.sh       ← Script 1: System Identity Report
    ├── script2.sh       ← Script 2: FOSS Package Inspector
    ├── script3.sh       ← Script 3: Disk and Permission Auditor
    ├── script4.sh       ← Script 4: Log File Analyzer
    └── script5.sh       ← Script 5: Open Source Manifesto Generator
```

---

## Scripts Overview

### Script 1 — System Identity Report
**File:** `scripts/script1.sh`

Displays a formatted welcome screen for the Linux system. Shows the distribution name, kernel version, current user, home directory, system uptime, current date/time, and a note about the open-source licenses covering the OS and the audited software (Python).

**Concepts used:** Variables, `echo`, command substitution `$()`, `/etc/os-release`, `uname`, `whoami`, `uptime`, `date`, formatted output.

---

### Script 2 — FOSS Package Inspector
**File:** `scripts/script2.sh`

Checks whether a given open-source package is installed on the system, retrieves its version, license, and summary from the package manager, and uses a `case` statement to print an open-source philosophy note about the package.

**Concepts used:** `if-then-else`, `case` statement, `command -v`, `rpm -qi`, `dpkg -l`, `apt-cache show`, `grep`, command-line arguments `$1`.

---

### Script 3 — Disk and Permission Auditor
**File:** `scripts/script3.sh`

Loops through key Linux system directories and Python-specific installation paths. Reports each location's size, permissions, owner, and type. Detects the installed Python version automatically.

**Concepts used:** `for` loop with arrays, `ls -ld`, `du -sh`, `awk`, `cut`, `printf` for tabular output, `if [ -d ]` and `if [ -f ]` for type checking.

---

### Script 4 — Log File Analyzer
**File:** `scripts/script4.sh`

Reads a log file line by line, counts occurrences of a keyword (default: `error`), and prints a summary with the last 5 matching lines. Includes retry logic for empty files and generates a sample log if none is provided.

**Concepts used:** `while IFS= read -r` loop, `if-then` inside loop, counter variables `$(( ))`, `grep -iq`, `tail -5`, `mktemp`, command-line arguments `$1` and `$2`.

---

### Script 5 — Open Source Manifesto Generator
**File:** `scripts/script5.sh`

Interactively asks the user three questions and composes a personalised open-source philosophy manifesto using their answers. Saves the result to a `.txt` file named after the current user.

**Concepts used:** `read -p` for interactive input, string concatenation, `here-doc` (`<<EOF`), writing to file with `>` and `>>`, `date` formatting, functions as aliases, `cat` to display output.

---

## How to Run Each Script on Linux

### Prerequisites

- A Linux system (Ubuntu, Fedora, Debian, Arch, or any major distro)
- Bash shell (bash version 4.0 or higher recommended)
- Python 3 installed (`sudo apt install python3` or `sudo dnf install python3`)
- Make scripts executable before running

### Step 1 — Clone the repository

```bash
git clone https://github.com/rahulvermadot/oss-audit-24BAI10964.git
cd oss-audit-24BAI10964/scripts
```

### Step 2 — Make all scripts executable

```bash
chmod +x script1.sh
chmod +x script2.sh
chmod +x script3.sh
chmod +x script4.sh
chmod +x script5.sh
```

### Step 3 — Run each script

**Script 1 — System Identity Report**
```bash
./script1.sh
```
No arguments required. Displays system information immediately.

---

**Script 2 — FOSS Package Inspector**
```bash
# Inspect the default package (python3)
./script2.sh

# Inspect a specific package
./script2.sh firefox
./script2.sh git
./script2.sh vlc
```
The package name is passed as the first argument. Defaults to `python3` if omitted.

---

**Script 3 — Disk and Permission Auditor**
```bash
./script3.sh
```
No arguments required. Automatically detects the Python version and audits both system directories and Python installation paths.

---

**Script 4 — Log File Analyzer**
```bash
# Analyze a real system log for 'error' (default keyword)
./script4.sh /var/log/syslog

# Analyze for a custom keyword
./script4.sh /var/log/syslog warning

# Run with no arguments — will use a generated sample log
./script4.sh
```
Arguments: `$1` = path to log file, `$2` = keyword to search (default: `error`).

---

**Script 5 — Open Source Manifesto Generator**
```bash
./script5.sh
```
Interactive — the script will ask you three questions. Answer each prompt and press Enter. Your manifesto is saved to `manifesto_rahulvermadot.txt` and displayed on screen.

---

## Dependencies

| Script | Dependencies | Notes |
|--------|-------------|-------|
| Script 1 | `bash`, `uname`, `whoami`, `uptime`, `date`, `/etc/os-release` | Available on all Linux systems |
| Script 2 | `rpm` (RPM-based) OR `dpkg`/`apt-cache` (Debian-based) | Adapts automatically to distro |
| Script 3 | `bash`, `ls`, `du`, `awk`, `cut`, `python3` | Python 3 required for path detection |
| Script 4 | `bash`, `grep`, `tail`, `mktemp` | All standard Linux utilities |
| Script 5 | `bash`, `date`, `cat` | No external dependencies |

All dependencies are standard utilities present on any Linux system with Python 3 installed.

---

## Software Audited

**Python** is a high-level, general-purpose programming language created by Guido van Rossum and first released in 1991. It is distributed under the **Python Software Foundation License (PSF License) version 2**, a permissive open-source license that grants all four essential software freedoms (run, study, modify, distribute) without requiring modifications to be shared back.

- **Official website:** https://www.python.org
- **Source code:** https://github.com/python/cpython
- **License text:** https://www.python.org/psf/license/
- **PSF (Python Software Foundation):** https://www.python.org/psf/

---

## Academic Integrity

All written content in the project report is original work. Scripts were written and tested on a live Linux system. Any external resources used are cited in the report's References section.

---

*Submitted as part of the OSS NGMC Capstone Project — VITyarthi*
