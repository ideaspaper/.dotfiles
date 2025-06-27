autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

if [ -d ~/.zsh ]; then
  for file in ~/.zsh/*.zsh; do
    [ -r "$file" ] && source "$file"
  done
fi
