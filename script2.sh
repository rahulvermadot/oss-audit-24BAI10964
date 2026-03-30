#!/bin/bash
# =============================================================
# Script 2: FOSS Package Inspector
# Course  : Open Source Software | OSS NGMC Capstone Project
# Subject : Python (PSF License)
# Purpose : Check if a given open-source package is installed,
#           display its version/license/summary, and print a
#           philosophical note using a case statement.
# Usage   : ./script2_foss_inspector.sh [package-name]
#           Default package is 'python3' if none is provided.
# =============================================================

# --- Set the package to inspect (accept as argument or use default) ---
PACKAGE=${1:-"python3"}   # Default to python3 if no argument is given

echo "============================================================"
echo "         FOSS PACKAGE INSPECTOR"
echo "============================================================"
echo "  Checking package: $PACKAGE"
echo "------------------------------------------------------------"

# --- Detect package manager and check if package is installed ---
# We support both RPM-based (Fedora/RHEL/CentOS) and Debian-based (Ubuntu) distros.

if command -v rpm &>/dev/null; then
    # RPM-based system: use rpm -q to query
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "  STATUS  : INSTALLED (RPM-based system)"
        echo ""
        # Display version, license, and summary from RPM metadata
        rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary|URL)" | \
            while IFS= read -r line; do
                echo "  $line"
            done
    else
        echo "  STATUS  : NOT INSTALLED"
        echo "  Tip     : Install with: sudo dnf install $PACKAGE"
    fi

elif command -v dpkg &>/dev/null; then
    # Debian-based system: use dpkg -l to query
    if dpkg -l "$PACKAGE" &>/dev/null 2>&1 | grep -q "^ii"; then
        echo "  STATUS  : INSTALLED (Debian-based system)"
        echo ""
        # Show package details using apt-cache show
        apt-cache show "$PACKAGE" 2>/dev/null | grep -E "^(Version|Section|Homepage|Description)" | \
            while IFS= read -r line; do
                echo "  $line"
            done
    else
        # Try python3 as fallback if 'python' was given
        echo "  STATUS  : NOT INSTALLED (or not found as '$PACKAGE')"
        echo "  Tip     : Install with: sudo apt install $PACKAGE"
    fi

else
    # Fallback: try 'which' to find if the binary exists at all
    if which "$PACKAGE" &>/dev/null; then
        echo "  STATUS  : Binary found at $(which $PACKAGE)"
        "$PACKAGE" --version 2>/dev/null || echo "  (version flag not supported)"
    else
        echo "  STATUS  : Package not found. No known package manager detected."
    fi
fi

echo ""
echo "------------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "------------------------------------------------------------"

# --- Case statement: print a philosophy note based on package name ---
case "$PACKAGE" in
    python3 | python)
        echo "  Python : Born from a community, governed by a foundation."
        echo "  The PSF License ensures Python remains free for everyone —"
        echo "  students, researchers, startups, and enterprises alike."
        echo "  'We are all equal before a fish.' — Guido van Rossum"
        ;;
    httpd | apache2)
        echo "  Apache : The web server that built the open internet."
        echo "  The Apache License 2.0 allows even commercial use and"
        echo "  modification — making it the backbone of millions of sites."
        ;;
    mysql | mariadb)
        echo "  MySQL  : Open source at the heart of millions of apps."
        echo "  Its dual-license (GPL + Commercial) model is a fascinating"
        echo "  case study in how companies monetize free software."
        ;;
    firefox)
        echo "  Firefox: A nonprofit browser fighting for an open web."
        echo "  Mozilla's mission proves that open-source can compete"
        echo "  with trillion-dollar corporations on principle."
        ;;
    vlc)
        echo "  VLC    : Built by students in Paris, plays anything."
        echo "  LGPL means it can be embedded in commercial software —"
        echo "  a gift to the world from the VideoLAN community."
        ;;
    git)
        echo "  Git    : Linus Torvalds built Git in 2005 when a proprietary"
        echo "  tool failed him. Today it powers all of software development."
        echo "  GPL v2 keeps it free — just like the kernel it manages."
        ;;
    libreoffice)
        echo "  LibreOffice: Born from a community fork of OpenOffice.org."
        echo "  A lesson in what happens when a community reclaims its tools"
        echo "  from a corporation that doesn't share its values."
        ;;
    *)
        # Generic message for any other package
        echo "  $PACKAGE : Every open-source tool carries a promise —"
        echo "  that knowledge shared freely grows faster than knowledge hoarded."
        echo "  Whatever this package does, someone gave it to the world for free."
        ;;
esac

echo ""
echo "============================================================"
