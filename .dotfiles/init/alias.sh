# Check for WSL
if [[ -f /proc/version ]] && grep -qi microsoft /proc/version 2>/dev/null; then
    alias files=explorer.exe
fi
