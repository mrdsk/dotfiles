#!/bin/bash

# download dotfiles
download_dotfiles() {
  print_title "Download dotfiles: Start!"

  if [ -d "./dotfiles" ]; then
    print_warning "dotfiles: already exists."
  else
    print_message "Downloading..."
    git clone git@github.com:mrdsk/dotfiles.git > /dev/null 2>&1
  fi

  print_success "Download dotfiles: Complete!"
}

# create symlinks
create_symlinks() {
  print_title "Create synlinks: Start!"

  cd dotfiles

  for f in .??*
  do
    filepath="$(pwd)/${f}"
    [[ $f == .git ]] && continue
    test -r ~/$f     && print_warning "already exists: ~/$f" && continue

    ln -s $filepath ~/$f
    [[ $? == 0 ]] && print_success "make: ~/$f -> $filepath"
  done

  cd ..

  print_success "Create symlinks: Complete!"
}

# installs
install_xcode() {
  print_title "Xcode"

  if [ -d "$(xcode-select -p)" ]; then
    print_warning "already installed: xcode-select"
  else
    xcode-select --install
    print_success "install: xcode-select"
  fi
}

# Print utils
print_error() {
  printf "\033[31m    [×] $1\033[m\n"
}

print_success() {
  printf "\033[32m    [o] $1\033[m\n"
}

print_warning() {
  printf "\033[33m    [!] $1\033[m\n"
}

print_title() {
  printf "\n\n\033[35m---$1---\033[m\n\n"
}

print_message() {
  printf "    $1\n"
}

# Main
main() {
  sudo -v

  cd $HOME
  mkdir -p git && cd git

  download_dotfiles
  create_symlinks

  install_xcode
}

main
