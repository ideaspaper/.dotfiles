if [ -d "$HOME/bin/nvim/bin" ]; then
  export PATH="$HOME/bin/nvim/bin:$PATH"
fi

if [ -n "$(go env GOPATH 2>/dev/null)" ]; then
  GOPATH_BIN="$(go env GOPATH)/bin"
  if [ -d "$GOPATH_BIN" ]; then
    export PATH="$PATH:$GOPATH_BIN"
  fi
fi
