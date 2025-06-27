autoload -Uz compinit
compinit

setopt no_beep

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

if [ -d ~/.zsh ]; then
  for file in ~/.zsh/*.zsh; do
    [ -r "$file" ] && source "$file"
  done
fi
