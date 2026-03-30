#!/bin/bash
# =============================================================
# Script 1: System Identity Report
# Course  : Open Source Software | OSS NGMC Capstone Project
# Subject : Python (PSF License)
# Purpose : Display a welcome/identity screen for the Linux
#           system, showing OS info, user, uptime, and a note
#           about the open-source license covering the OS.
# =============================================================

# --- Student Details ---
STUDENT_NAME="Rahul Rajkumar Verma"         
REG_NUMBER="24BAI10964"      
SOFTWARE_CHOICE="Python"        

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                         # Kernel version
DISTRO=$(cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Distro name
USER_NAME=$(whoami)                        # Current logged-in user
HOME_DIR=$HOME                             # Home directory of current user
UPTIME=$(uptime -p)                        # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')       # Formatted current date
CURRENT_TIME=$(date '+%H:%M:%S')           # Current time
HOSTNAME=$(hostname)                       # Machine hostname

# --- Display the identity report with formatted output ---
echo "============================================================"
echo "        OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT         "
echo "============================================================"
echo ""
echo "  Student  : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software : $SOFTWARE_CHOICE (Licensed under PSF License)"
echo "  Host     : $HOSTNAME"
echo ""
echo "------------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "------------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Current User : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date         : $CURRENT_DATE"
echo "  Time         : $CURRENT_TIME"
echo ""
echo "------------------------------------------------------------"
echo "  LICENSE NOTE"
echo "------------------------------------------------------------"
# The Linux kernel itself is covered by GPL v2.
# Python, our audited software, uses the PSF (Python Software Foundation) License.
echo "  This OS (Linux Kernel) is licensed under: GPL v2"
echo "  Audited Software (Python) is licensed under: PSF License"
echo "  Both licenses grant the four essential software freedoms:"
echo "    1. Freedom to run the program for any purpose"
echo "    2. Freedom to study and modify the source code"
echo "    3. Freedom to redistribute copies"
echo "    4. Freedom to distribute modified versions"
echo ""
echo "============================================================"
echo "  'With great power comes great responsibility.' — Open Source"
echo "============================================================"
