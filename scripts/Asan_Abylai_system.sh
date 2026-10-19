#!/bin/bash
# Asan_Abylai_system.sh
# Shows student information and basic system information.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INFO_FILE="$PROJECT_DIR/Asan_Abylai_info.txt"

OS_NAME="$(sed -n 's/^PRETTY_NAME="\(.*\)"/\1/p' /etc/os-release 2>/dev/null)"
[ -n "$OS_NAME" ] || OS_NAME="$(uname -s)"

echo "=============================="
echo "Student Information"
echo "=============================="
echo
echo "Name: Abylai"
echo "Surname: Asan"
echo "Group: IT2-2301"
echo "Student ID: 37804"
echo
echo "=============================="
echo "System Information"
echo "=============================="
echo
echo "Username: $(whoami)"
echo "Hostname: $(hostname)"
echo "Current Date: $(date)"
echo "Operating System: $OS_NAME ($(uname -sr))"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $3 " used of " $2 " (" $5 ")"}')"
echo "Memory Usage: $(free -h | awk '/^Mem:/ {print $3 " used of " $2}')"
echo

if [ -f "$INFO_FILE" ]; then
    echo "Student information file exists."
else
    echo "Student information file does not exist."
fi
