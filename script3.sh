#!/bin/bash
# =============================================================
# Script 3: Disk and Permission Auditor
# Course  : Open Source Software | OSS NGMC Capstone Project
# Subject : Python (PSF License)
# Purpose : Loop through key Linux directories, report their
#           size, owner, and permissions. Also specifically
#           checks Python's configuration directories.
# Concepts: for loop, arrays, ls -ld, du, awk, cut, if-then
# =============================================================

echo "============================================================"
echo "          DISK AND PERMISSION AUDITOR"
echo "============================================================"
echo ""

# --- List of important system directories to audit ---
# These are standard Linux filesystem locations every sysadmin should know.
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/usr/lib" "/tmp" "/opt" "/root")

echo "  SYSTEM DIRECTORY AUDIT"
echo "------------------------------------------------------------"
printf "  %-20s %-12s %-20s %-10s\n" "Directory" "Size" "Permissions" "Owner"
echo "  $(printf '%.0s-' {1..65})"

# --- Loop through each directory and report details ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # Extract permissions and owner using ls -ld and awk
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3 ":" $4}')

        # Get human-readable size; suppress permission errors with 2>/dev/null
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Print formatted row for this directory
        printf "  %-20s %-12s %-20s %-10s\n" "$DIR" "${SIZE:-N/A}" "$PERMS" "$OWNER"
    else
        # Directory does not exist on this system
        printf "  %-20s %-12s\n" "$DIR" "[NOT FOUND]"
    fi
done

echo ""
echo "------------------------------------------------------------"
echo "  PYTHON-SPECIFIC DIRECTORY AUDIT"
echo "------------------------------------------------------------"
echo "  Checking Python installation paths on this system..."
echo ""

# --- Find Python's version to construct correct paths ---
# 'python3 --version' gives e.g. "Python 3.11.2" — extract the major.minor part
PYTHON_VERSION=$(python3 --version 2>/dev/null | awk '{print $2}' | cut -d. -f1,2)

if [ -z "$PYTHON_VERSION" ]; then
    echo "  WARNING: python3 not found in PATH. Skipping Python path audit."
else
    echo "  Detected Python version: $PYTHON_VERSION"
    echo ""

    # Common Python-related directories to check
    PYTHON_DIRS=(
        "/usr/lib/python${PYTHON_VERSION}"
        "/usr/lib/python3"
        "/usr/local/lib/python${PYTHON_VERSION}"
        "/etc/python${PYTHON_VERSION}"
        "/usr/bin/python3"
        "/usr/local/bin/python3"
    )

    printf "  %-40s %-12s %-20s\n" "Python Path" "Type" "Permissions"
    echo "  $(printf '%.0s-' {1..75})"

    for PYPATH in "${PYTHON_DIRS[@]}"; do
        if [ -d "$PYPATH" ]; then
            # It's a directory
            PERMS=$(ls -ld "$PYPATH" | awk '{print $1}')
            printf "  %-40s %-12s %-20s\n" "$PYPATH" "[directory]" "$PERMS"
        elif [ -f "$PYPATH" ]; then
            # It's a file (like the binary itself)
            PERMS=$(ls -l "$PYPATH" | awk '{print $1}')
            printf "  %-40s %-12s %-20s\n" "$PYPATH" "[file]" "$PERMS"
        else
            printf "  %-40s %-12s\n" "$PYPATH" "[not found]"
        fi
    done
fi

echo ""
echo "------------------------------------------------------------"
echo "  PERMISSION LEGEND"
echo "------------------------------------------------------------"
echo "  r = read  |  w = write  |  x = execute  |  - = no permission"
echo "  Format: [type][owner][group][others]"
echo "  Example: drwxr-xr-x => directory, owner=rwx, group=rx, others=rx"
echo ""
echo "  WHY THIS MATTERS FOR OPEN SOURCE:"
echo "  Python's libraries are world-readable (r--) so any user can"
echo "  inspect, learn from, and verify the source. This is the Linux"
echo "  filesystem embodying open-source values — transparency by default."
echo ""
echo "============================================================"
