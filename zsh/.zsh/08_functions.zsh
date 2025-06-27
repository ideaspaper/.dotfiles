_validate_git_installed() {
  command -v git >/dev/null 2>&1 || {
    echo "Git is not installed. Please install Git to use this command."
    return 1
  }
}

_validate_git_repo() {
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not inside a Git repository." >&2
    return 1
  fi
}

mkcd() {
  if [ -z "$1" ]; then
    echo "Usage: mkcd <directory>"
    return 1
  fi

  mkdir -p "$1" && cd "$1"
}

mkproj() {
  if [ -z "$1" ]; then
    echo "Usage: mkproj <project-name>"
    return 1
  fi

  _validate_git_installed || return 1

  if [ -d "$1" ]; then
    echo "Folder '$1' already exists. Aborting."
    return 1
  fi

  mkcd "$1" || return 1

  local folder_name
  folder_name=$(basename "$PWD")

  echo "# $folder_name" > README.md
  git init -q
  git add README.md
  git commit -m "feat: Initial commit" >/dev/null 2>&1

  echo "Project '$folder_name' created and Git repository initialized."
}

gitroot() {
  _validate_git_installed || return 1
  _validate_git_repo || return 1

  cd "$(git rev-parse --show-toplevel)" || return 1
  echo "Moved to Git root: $PWD"
}
