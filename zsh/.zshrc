autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

if [ -d ~/.zsh ]; then
  for file in ~/.zsh/*.zsh; do
    [ -r "$file" ] && source "$file"
  done
fi
