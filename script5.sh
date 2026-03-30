#!/bin/bash
# =============================================================
# Script 5: The Open Source Manifesto Generator
# Course  : Open Source Software | OSS NGMC Capstone Project
# Subject : Python (PSF License)
# Purpose : Interactively ask the user 3 questions, then compose
#           a personalised open-source philosophy statement and
#           save it to a .txt file.
# Concepts: read (user input), string concatenation, writing to
#           file with >, date command, aliases (demonstrated),
#           here-doc (<<), formatted output
# =============================================================

# --- Alias demonstration ---
# In real interactive shells, aliases can be defined like this.
# Here we define a function that acts as an alias for formatted printing.
# Note: aliases don't export to scripts, so we use a function instead.
print_separator() {
    echo "============================================================"
}

print_separator
echo "    OPEN SOURCE MANIFESTO GENERATOR"
echo "    Python Audit | OSS NGMC Capstone Project"
print_separator
echo ""
echo "  Answer three questions honestly."
echo "  Your answers will be woven into a personal manifesto"
echo "  about open source — saved as a text file."
echo ""
print_separator
echo ""

# --- Question 1: A tool the user uses every day ---
read -rp "  1. Name one open-source tool you use every day: " TOOL

# --- Question 2: What freedom means to them ---
read -rp "  2. In one word, what does 'freedom' mean to you?  " FREEDOM

# --- Question 3: Something they would build and share ---
read -rp "  3. Name one thing you would build and share freely: " BUILD

echo ""

# --- Validate inputs — don't allow blank answers ---
if [ -z "$TOOL" ] || [ -z "$FREEDOM" ] || [ -z "$BUILD" ]; then
    echo "  ERROR: All three answers are required. Please re-run the script."
    exit 1
fi

# --- Capture current date and the current user's name ---
DATE=$(date '+%d %B %Y')
AUTHOR=$(whoami)

# --- Construct the output filename using the current username ---
OUTPUT="manifesto_${AUTHOR}.txt"

# --- Compose the manifesto using string concatenation and a here-doc ---
# We write directly to the output file using > (overwrite) and >> (append).

# Write the header
echo "============================================================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Written by: $AUTHOR | Date: $DATE" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Compose the main paragraph using the user's three answers
# This demonstrates string concatenation — building a paragraph from variables.
cat >> "$OUTPUT" << EOF
I am a participant in the open-source movement, not just a consumer of it.

Every day, I rely on $TOOL — a tool I did not build, did not pay for, and
yet can trust completely, because its source code is open for the world to
read, question, and improve. That is not a small thing. That is a revolution
in how human knowledge works.

To me, freedom means $FREEDOM. In the context of software, that word takes on
a specific and powerful meaning: the freedom to run, study, modify, and share.
These are not abstract ideals. They are practical rights that determine whether
technology serves its users or controls them.

If I could build one thing and give it freely to the world, it would be $BUILD.
Not because I would gain nothing — but because I understand now that the greatest
gains in software history have come not from locking ideas away, but from releasing
them. Linux. Python. The World Wide Web. Git. All of them were gifts.

I believe in building in the open. I believe in reading the code. I believe that
transparency is not a weakness — it is the foundation of trust in a digital world.

This manifesto was generated as part of the Open Source Audit capstone project,
auditing Python — a language built by a community, for a community, and returned
to that community under the PSF License every single day.

Stand on the shoulders of giants. Then reach higher. Then let others stand on yours.
EOF

echo "" >> "$OUTPUT"
echo "------------------------------------------------------------" >> "$OUTPUT"
echo "  Signed: $AUTHOR | $DATE" >> "$OUTPUT"
echo "  Software Audited: Python (PSF License)" >> "$OUTPUT"
echo "  Tool I use daily: $TOOL" >> "$OUTPUT"
echo "  My word for freedom: $FREEDOM" >> "$OUTPUT"
echo "  What I would build: $BUILD" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# --- Confirm and display the saved manifesto ---
echo ""
print_separator
echo "  Manifesto saved to: $OUTPUT"
print_separator
echo ""

# Display the generated file to the terminal
cat "$OUTPUT"

echo ""
print_separator
echo "  'Given enough eyeballs, all bugs are shallow.' — Eric S. Raymond"
print_separator
