#!/bin/bash
# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
# â  Sir Prize Linux â local Easter egg tester                  â
# â  Run this on any Ubuntu/Debian box to preview the fun bits   â
# ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
#
# Usage:  bash test-locally.sh
# No root needed. Installs a few packages with apt if missing.

set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN="$DIR/includes.chroot/usr/local/bin"
SKEL="$DIR/includes.chroot/etc/skel"

# Install fun packages if apt is available
if command -v apt-get &>/dev/null && [[ $EUID -eq 0 ]]; then
    apt-get install -y cowsay fortune-mod figlet lolcat cmatrix sl 2>/dev/null || true
elif command -v apt-get &>/dev/null; then
    sudo apt-get install -y cowsay fortune-mod figlet lolcat cmatrix sl 2>/dev/null || true
fi

# Source the welcome script (non-interactive simulation)
export HOME="${HOME:-/tmp}"
source "$SKEL/.bash_aliases" 2>/dev/null || true

echo ""
echo -e "\e[38;5;213mââââââââââââââââââââââââââââââââââââââââââââ\e[0m"
echo -e "\e[38;5;213mâÕ  Sir Prize Linux â Easter Egg Preview   â\e[0m"
echo -e "\e[38;5;213mââââââââââââââââââââââââââââââââââââââââââââ\e[0m"
echo ""

COMMANDS=(surprise coffee magic secret party answer penguin vibecheck)
for cmd in "${COMMANDS[@]}"; do
    echo -e "\e[38;5;220mâââ \$ $cmd ââââââââââââââââââââââââââââââââ\e[0m"
    bash "$BIN/$cmd" 2>/dev/null || true
    echo ""
    read -p "  [Enter for next, q to quit] " -r KEY
    [[ "$KEY" == "q" ]] && break
done

echo ""
echo -e "\e[38;5;119mâ  Preview complete! Run sudo ./build.sh to build the full ISO.\e[0m"
echo ""
