# Enable colored output in man pages
export LESS_TERMCAP_mb=$'\e[1;31m'    # Begin blinking text (red)
export LESS_TERMCAP_md=$'\e[1;32m'    # Begin bold text (green)
export LESS_TERMCAP_me=$'\e[0m'       # End mode (reset)
export LESS_TERMCAP_se=$'\e[0m'       # End standout mode
export LESS_TERMCAP_so=$'\e[1;44;33m' # Begin standout mode (yellow on blue background)
export LESS_TERMCAP_ue=$'\e[0m'       # End underline mode
export LESS_TERMCAP_us=$'\e[1;37m'    # Begin underline mode (white)

### PATH and Environment Setup ###
# Add Go bin and Neovim bin directories to PATH
export PATH=$HOME/bin/nvim/bin:$PATH:$(go env GOPATH)/bin

### History Settings ###
# Disable persistent history (commands won't be saved between sessions)
unset HISTFILE
SAVEHIST=0
HISTSIZE=0

### Aliases ###
# Source user-defined aliases if available
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

### Tool Initializations ###
# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# pyenv for managing Python versions
eval "$(pyenv init - zsh)"

# atuin shell history replacement
eval "$(atuin init zsh)"

# starship prompt initialization
eval "$(starship init zsh)"
