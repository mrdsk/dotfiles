# anyenv
if [ -d "$HOME/.anyenv/bin" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
elif type anyenv > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi
