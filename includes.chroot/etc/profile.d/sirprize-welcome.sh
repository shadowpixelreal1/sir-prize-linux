#!/bin/bash
# Sir Prize Linux â welcome script (runs at every login)
# Lives in /etc/profile.d/ so it fires for all users

_sp_color() { printf '\e[%sm' "$1"; }
RED=31; GRN=32; YLW=33; BLU=34; MAG=35; CYN=36; WHT=37; RST=0

QUOTES=(
  "\"There are only 10 types of people: those who understand binary and those who don't.\""
  "\"A computer once beat me at chess, but it was no match for me at kickboxing.\" â Emo Philips"
  "\"The box said 'Requires Windows 95 or better.' So I installed Linux.\" â unknown"
  "\"Real programmers count from 0.\""
  "\"sudo make me a sandwich â it works here. Try it.\""
  "\"There's no place like 127.0.0.1\""
  "\"rm -rf /problems â would not recommend.\""
  "\"I would love to change the world, but they won't give me the source code.\""
  "\"To iterate is human, to recurse is divine.\""
  "\"Keyboard not found. Press F1 to continue.\""
  "\"It works on my machine Â¯\_(ã)_/Â¯\""
  "\"// TODO: make this less terrible\""
  "\"404: Motivation not found.\""
  "\"Have you tried turning it off and on again?\""
  "\"The best error message is the one that never shows up.\""
  "\"Unix is user-friendly; it's just very choosy about who its friends are.\""
)

IDX=$(( $(date +%M%S) % ${dQUOTES[@]} ))
QUOTE="${QUOTES[$IDX]}"

HOUR=$(date +%H)
if   (( HOUR < 12 )); then GREET="Good morning"
elif (( HOUR < 17 )); then GREET="Good afternoon"
elif (( HOUR < 21 )); then GREET="Good evening"
else                       GREET="Burning the midnight oil"
fi

echo ""
_sp_color $MAG; echo "  â¨ $GREET, $(whoami)! Welcome to Sir Prize Linux."; _sp_color $RST
_sp_color $CYN; echo "  $(date '+%A, %B %-d %Y  â¢  %H:%M')"; _sp_color $RST
echo ""
_sp_color $YLW; echo "  $QUOTE"; _sp_color $RST
echo ""

STAMP="$HOME/.sirprize_welcomed"
if [[ ! -f "$STAMP" ]]; then
    touch "$STAMP"
    echo ""
    _sp_color $GRN
    cat << 'FIRSTBOOT'
  ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
  â                                                          â
  â   ð  CONGRATULATIONS! You've opened the box!  ð         â
  â                                                          â
  â   This is your FIRST boot of Sir Prize Linux.             â
  â                                                          â
  â   Hidden inside this system:                              â
  â      â¢ 9  secret terminal commands                        â
  â      â¢ 5  hidden files in your home directory              â
  â      â¢ 1  very important answer                           â
  â      â¢ â  good vibes                                      â
  â                                                           â
  â   Start by typing:  secret                                 â
  â                                                          â
  âââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
FIRSTBOOT
    _sp_color $RST
    echo ""
fi
