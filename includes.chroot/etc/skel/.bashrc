# ~/.bashrc â Sir Prize Linux edition
# "A shell so beautiful it should be illegal."

case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
shopt -s checkwinsize

# ââ rainbow PS1 ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
PS1='\[\e[0m\]\[\e[38;5;213m\] \[\e[38;5;141m\]\u\[\e[0m\]\[\e[38;5;245m\]@\[\e[38;5;81m\]\h\[\e[0m\]\[\e[38;5;245m\]:\[\e[38;5;220m\]\w\[\e[0m\]\[\e[38;5;199m\] âº\[\e[0m\] '

# ââ colors âââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# ââ aliases ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# ââ every 42nd command gets a fortune âââââââââââââââââââââââââââââââââââââââââ
_SP_CMD_COUNT_FILE="$HOME/.sp_cmd_count"
_sp_cmd_counter() {
    local count
    count=$(cat "$_SP_CMD_COUNT_FILE" 2>/dev/null || echo 0)
    count=$(( count + 1 ))
    echo "$count" > "$_SP_CMD_COUNT_FILE"
    if (( count % 42 == 0 )); then
        echo -e "\n\e[38;5;220m   Command #$count! Here is your reward:\e[0m"
        fortune 2>/dev/null || echo "  \"You are doing great!\""
        echo ""
    fi
}
PROMPT_COMMAND="_sp_cmd_counter${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# ââ sudo sandwich Easter egg âââââââââââââââââââââââââââââââââââââââââââââââââââ
sudo() {
    if [[ "$*" == "make me a sandwich" ]]; then
        echo -e "\n\e[38;5;220m  Okay. \e[0m\n"
        cat << 'SANDWICH'
              _____________________
             |  ___________________  |
             | |  SIR PRIZE SPECIAL | |
             | |___________________| |
             |  ~ ~ ~ ~ ~ ~ ~ ~ ~ ~  |
             | |           | |
             | |___________________| |
             |_____________________|
              \___________________/
SANDWICH
        echo ""
        return 0
    fi
    command sudo "$@"
}

# ââ bash completion âââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
if ! shopt -oq posix; then
    [ -f /usr/share/bash-completion/bash_completion ] && \
        . /usr/share/bash-completion/bash_completion
fi

# ââ neofetch on login ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
command -v neofetch &>/dev/null && neofetch
