_validate_git_installed() {
  command -v git >/dev/null 2>&1 || {
    printf "Git is not installed. Please install Git to use this command.\n" >&2
    return 1
  }
}

_validate_git_repo() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    printf "Not inside a Git repository.\n" >&2
    return 1
  fi
}

mkcd() {
  if [ -z "$1" ]; then
    printf "Usage: mkcd <directory>\n" >&2
    return 1
  fi

  mkdir -p "$1" && cd "$1"
}

mkproj() {
  if [ -z "$1" ]; then
    printf "Usage: mkproj <project-name>\n" >&2
    return 1
  fi

  _validate_git_installed || return 1

  if [ -d "$1" ]; then
    printf "Folder '%s' already exists. Aborting.\n" "$1" >&2
    return 1
  fi

  mkcd "$1" || return 1

  local folder_name
  folder_name=$(basename "$PWD")

  printf "# %s\n" "$folder_name" > README.md
  printf "### OSX ###\n.DS_Store\n.AppleDouble\n.LSOverride\n" > .gitignore

  git init -q
  git add README.md .gitignore
  git commit -m "feat: Initial commit" >/dev/null 2>&1

  printf "Project '%s' created and Git repository initialized.\n" "$folder_name"
}

groot() {
  _validate_git_installed || return 1
  _validate_git_repo || return 1

  cd "$(git rev-parse --show-toplevel)" || return 1
  printf "Moved to Git root: %s\n" "$PWD"
}
