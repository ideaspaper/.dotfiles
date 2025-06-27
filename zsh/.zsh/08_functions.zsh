mkcd() {
  if [ -z "$1" ]; then
    echo "⚠️ Usage: mkcd <directory>"
    return 1
  fi

  mkdir -p "$1" && cd "$1"
}

mkproj() {
  if [ -z "$1" ]; then
    echo "⚠️  Usage: mkproj <project-name>"
    return 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    echo "❌ Git is not installed. Please install Git to use this command."
    return 1
  fi

  if [ -d "$1" ]; then
    echo "❌ Folder '$1' already exists. Aborting."
    return 1
  fi

  mkcd "$1" || return 1

  local folder_name
  folder_name=$(basename "$PWD")

  echo "# $folder_name" > README.md
  git init -q
  git add README.md
  git commit -m "feat: Initial commit" >/dev/null 2>&1

  echo "✅ Project '$folder_name' created and Git repository initialized."
}
