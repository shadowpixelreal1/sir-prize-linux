# Sir Prize Linux â fun aliases

alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -alFh --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

alias cls='clear'
alias please='sudo'
alias reload='source ~/.bashrc && echo "â¿ï¸  Shell reloaded!"'
alias myip='curl -s ifconfig.me && echo ""'
alias weather='curl -s wttr.in/?format=3'
alias bigfiles='du -ah . | sort -rh | head -20'
alias ports='ss -tulpn'
alias update='sudo apt update && sudo apt upgrade -y'

alias hug='echo "$(whoami) needs a hug ð¤" | cowsay'
alias vibecheck='fortune | cowsay -f tux | lolcat'
alias shrug='echo "Â¯\_(â)_/Â®?
alias dontpanic='echo "DON'\''T PANIC" | figlet | lolcat'
alias coffee='coffee'
alias party='party'
alias magic='magic'
alias matrix='cmatrix -s -b'
alias nyan='nyancat'
alias lol='lolcat'
alias choo='sl -e'

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
