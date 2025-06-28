alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias md='mkdir -p'
alias rd='rmdir'

alias ls='ls -G'
alias ll='ls -l'
alias la='ls -la'
alias l='ls -lF'
alias l.='ls -d .*'
alias tree='tree -C'

alias grep='grep --color=auto'
alias f='find . -name'
alias which='command -v'

alias gcopy='git diff | pbcopy && printf "Unstaged changes copied to clipboard\n"'
alias gcopy-staged='git diff --cached | pbcopy && printf "Staged changes copied to clipboard\n"'
alias gcopy-all='git diff HEAD | pbcopy && printf "All changes copied to clipboard\n"'
alias gcopy-last='git show HEAD | pbcopy && printf "Last commit patch copied to clipboard\n"'

alias myip='curl -s https://ipinfo.io/ip; echo'
alias ping='ping -c 5'

alias reload='source ~/.zshrc'

alias pn='pnpm'
alias v='nvim'
alias vim='nvim'
alias lgit='lazygit'

alias ds-clean='find . -name .DS_Store -type f -delete 2>/dev/null; printf ".DS_Store files removed from current directory\n"'
alias ds-clean-home='find ~ -name .DS_Store -type f -delete 2>/dev/null; printf ".DS_Store files removed from home\n"'
