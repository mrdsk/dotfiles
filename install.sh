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

# create dotfile symlinks
create_dotfiles_symlinks() {
  print_title "Create dotfiles synlinks: Start!"

  cd dotfiles

  for f in .??*
  do
    filepath="$(pwd)/${f}"
    [[ $f == .git ]] && continue
    [[ $f == .bashrc.d ]] && continue
    test -r ~/$f     && print_warning "already exists: ~/$f" && continue

    ln -s $filepath ~/$f
    [[ $? == 0 ]] && print_success "make: ~/$f -> $filepath"
  done

  cd ..

  print_success "Create dotfiles symlinks: Complete!"
}

# create .bashrc.d symlinks
create_bashrcd_symlinks() {
  print_title "Create .bashrc.d synlinks: Start!"

  if [ -d "~/.bashrc.d" ]; then
    print_warning "~/.bashrc.d: already exists."
  else
    print_message "mkdir..."
    mkdir -p ~/.bashrc.d
  fi

  cd dotfiles/.bashrc.d

  for f in ??*
  do
    filepath="$(pwd)/${f}"

    test -r ~/.bashrc.d/$f && print_warning "already exists: ~/$f" && continue

    ln -s $filepath ~/.bashrc.d/$f
    [[ $? == 0 ]] && print_success "make: ~/.bashrc.d/$f -> $filepath"
  done
  cd ../..

  print_success "Create .bashrc.d symlinks: Complete!"
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
  create_dotfiles_symlinks
  create_bashrcd_symlinks
}

main
