#!/bin/bash
cd "$(dirname "$0")/_internal" || exit 1

open "Team Competition Dashboard.html"

if command -v python3 >/dev/null 2>&1; then
    python3 "server.py"
else
    python "server.py"
fi

echo
echo "Helper stopped."
read -n 1 -s -r -p "Press any key to continue..."
echo
