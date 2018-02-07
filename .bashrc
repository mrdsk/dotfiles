# .bashrc

# .bash_history settings
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%Y-%m-%dT%T%z '

# alias
alias l='ls -laFG'
alias v='vim'
alias g='git'
alias gd='git diff'
alias gs='git status'
alias gl='git log'
alias glp='git log -p'

# If you also want to write environment settings for each local
test -r ~/.bashrc_local  && . ~/.bashrc_local
