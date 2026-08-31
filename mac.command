#!/bin/bash
cd "$(dirname "$0")/_internal" || exit 1

if command -v python3 >/dev/null 2>&1; then
    PYTHON=python3
else
    PYTHON=python
fi

# The dashboard must be opened as http://127.0.0.1:8877/ (served by
# server.py itself), NOT as a double-clicked local file — browsers now
# silently block file:// pages from saving to a http://127.0.0.1 server.
"$PYTHON" "server.py" &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null' INT TERM

for i in $(seq 1 50); do
    if curl -s -o /dev/null "http://127.0.0.1:8877/state"; then
        break
    fi
    sleep 0.2
done

open "http://127.0.0.1:8877/"

wait "$SERVER_PID"

echo
echo "Helper stopped."
read -n 1 -s -r -p "Press any key to continue..."
echo
