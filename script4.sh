#!/bin/bash
# =============================================================
# Script 4: Log File Analyzer
# Course  : Open Source Software | OSS NGMC Capstone Project
# Subject : Python (PSF License)
# Purpose : Read a log file line by line, count occurrences of
#           a keyword (default: "error"), and print a summary
#           with the last 5 matching lines.
# Usage   : ./script4_log_analyzer.sh <logfile> [keyword]
#           Example: ./script4_log_analyzer.sh /var/log/syslog error
# Concepts: while-read loop, if-then, counter variables,
#           command-line arguments ($1, $2), grep, tail
# =============================================================

# --- Accept command-line arguments ---
LOGFILE=$1                   # First argument: path to log file
KEYWORD=${2:-"error"}        # Second argument: keyword to search (default: "error")

# --- Counters for tracking matches and total lines ---
COUNT=0          # Counts lines matching the keyword
TOTAL=0          # Counts total lines processed
WARN_COUNT=0     # Bonus: also count WARNING lines separately

echo "============================================================"
echo "            LOG FILE ANALYZER"
echo "============================================================"

# --- Validate that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  Usage: $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    echo "  No log file provided. Attempting to use a default log..."

    # Try common log file locations as fallback
    for TRY_LOG in /var/log/syslog /var/log/messages /var/log/dmesg; do
        if [ -f "$TRY_LOG" ]; then
            LOGFILE="$TRY_LOG"
            echo "  Using default log file: $LOGFILE"
            break
        fi
    done

    # If still no log file found, create a sample one for demonstration
    if [ -z "$LOGFILE" ] || [ ! -f "$LOGFILE" ]; then
        LOGFILE="/tmp/sample_python_audit.log"
        echo "  Creating a sample log file at $LOGFILE for demonstration..."
        cat > "$LOGFILE" <<'SAMPLELOG'
2024-01-15 10:01:22 INFO  Python interpreter started successfully
2024-01-15 10:01:23 INFO  Loading standard libraries
2024-01-15 10:01:24 WARNING Deprecated function called in module 'os.path'
2024-01-15 10:01:25 ERROR  ModuleNotFoundError: No module named 'requests'
2024-01-15 10:01:26 INFO  Attempting to import fallback module
2024-01-15 10:01:27 ERROR  ImportError: cannot import name 'urlopen' from 'urllib'
2024-01-15 10:01:28 WARNING SSL certificate verification disabled
2024-01-15 10:01:29 INFO  Retrying with alternative method
2024-01-15 10:01:30 ERROR  ConnectionRefusedError: [Errno 111] Connection refused
2024-01-15 10:01:31 INFO  Script execution completed with 3 errors
2024-01-15 10:01:32 WARNING Memory usage above 80% threshold
2024-01-15 10:01:33 ERROR  PermissionError: [Errno 13] Permission denied: '/etc/hosts'
2024-01-15 10:01:34 INFO  Cleanup complete
SAMPLELOG
    fi
fi

# --- Validate that the log file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  ERROR: File '$LOGFILE' not found."
    echo "  Please provide a valid log file path."
    exit 1
fi

# --- Check if the log file is empty; retry logic (do-while style) ---
RETRY=0
MAX_RETRIES=2   # Maximum number of retry prompts

while [ ! -s "$LOGFILE" ] && [ $RETRY -lt $MAX_RETRIES ]; do
    # File exists but is empty — ask user if they want to try another
    echo "  WARNING: '$LOGFILE' is empty."
    RETRY=$((RETRY + 1))
    read -rp "  Enter a different log file path (or press Enter to skip): " NEW_LOG
    if [ -n "$NEW_LOG" ] && [ -f "$NEW_LOG" ]; then
        LOGFILE="$NEW_LOG"
    else
        break   # Exit retry loop if no valid input given
    fi
done

echo ""
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD' (case-insensitive)"
echo "------------------------------------------------------------"

# --- Store matching lines in a temporary file for later display ---
TMPFILE=$(mktemp /tmp/log_matches_XXXXXX)

# --- Read the log file line by line using a while-read loop ---
while IFS= read -r LINE; do
    TOTAL=$((TOTAL + 1))   # Increment total line counter

    # Check if this line contains the search keyword (case-insensitive with -i)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))             # Increment match counter
        echo "$LINE" >> "$TMPFILE"       # Save matching line to temp file
    fi

    # Bonus: also count WARNING lines for richer summary
    if echo "$LINE" | grep -iq "warning"; then
        WARN_COUNT=$((WARN_COUNT + 1))
    fi

done < "$LOGFILE"   # Redirect file into the while loop

echo ""
echo "  ANALYSIS SUMMARY"
echo "------------------------------------------------------------"
echo "  Total lines scanned   : $TOTAL"
echo "  Lines with '$KEYWORD' : $COUNT"
echo "  Lines with 'warning'  : $WARN_COUNT"
echo ""

# --- Show the last 5 lines that matched the keyword ---
if [ $COUNT -gt 0 ]; then
    echo "  LAST 5 MATCHING LINES (containing '$KEYWORD'):"
    echo "  ------------------------------------------------------------"
    # Use tail to get the last 5 from the temp file, then indent each line
    tail -5 "$TMPFILE" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  No lines containing '$KEYWORD' were found."
fi

# --- Clean up temporary file ---
rm -f "$TMPFILE"

echo ""
echo "  OPEN SOURCE CONNECTION:"
echo "  Python's own logs (pip, interpreter, pytest) follow this exact"
echo "  structure — human-readable text files that any tool can parse."
echo "  This transparency is a core open-source value: no black boxes."
echo ""
echo "============================================================"
