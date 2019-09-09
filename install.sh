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
  print_title "Install Xcode: Start!"

  if [ -d "$(xcode-select -p)" ]; then
    print_warning "already installed: xcode-select"
  else
    xcode-select --install
    print_success "install: xcode-select"
  fi

  print_success "Install Xcode: Complete!"
}

install_brew_and_packages() {
  print_title "Install Brew And Packages: Start!"

  # brew
  if type brew > /dev/null 2>&1; then
    print_warning "already installed: homebrew"
  else
    print_message "Installing Homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    print_success "successfully installed"
  fi

  # brew update
  print_message "brew update..."
  if brew update > /dev/null 2>&1; then
    print_success "successfully updated"
  else
    print_error "unsuccessfully updated"
  fi

  print_message "brew doctor..."
  if brew doctor > /dev/null 2>&1; then
    print_success "ready to brew"
  else
    print_error "not ready to brew"
  fi

  brew tap homebrew/cask-drivers
  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-versions

  # brew cask
  print_message "Installing cask packages..."
  cask_packages=(
    docker
    google-chrome
    google-japanese-ime
    slack
  )
  for package in "${cask_packages[@]}"; do
    if brew cask list "$package" > /dev/null 2>&1; then
      print_warning "already installed: $package"
    elif brew cask install $package > /dev/null 2>&1; then
      print_success "successfully installed: $package"
    else
      print_error "unsuccessfully installed: $package"
    fi
  done

  # brew packages
  print_message "Installing brew packages..."
  brew_packages=(
    anyenv
    curl
    git
    graphviz
    jq
    lv
    tig
    wget
  )
  for package in "${brew_packages[@]}"; do
    if brew list "$package" > /dev/null 2>&1; then
      print_warning "already installed: $package"
    elif brew install $package > /dev/null 2>&1; then
      print_success "successfully installed: $package"
    else
      print_error "unsuccessfully installed: $package"
    fi
  done

  brew cleanup

  print_success "Install Brew And Packages: Complete!"
}

# setups
# but no tests
# setup_anyenv_rbenv() {
#   print_title "setup rbenv..."
#
#   sstephenson_plugins=(
#     ruby-build
#     rbenv-default-gems
#     rbenv-gem-rehash
#   )
#   for plugin in "${sstephenson_plugins[@]}"; do
#     if [ -d "~/.anyenv/envs/rbenv/plugins/$plugin" ]; then
#       print_warning "already cloned: $plugin"
#     else
#       git clone https://github.com/sstephenson/$plugin.git ~/.anyenv/envs/rbenv/plugins/$plugin
#     fi
#   done
#
#   if [ -d "~/.anyenv/envs/rbenv/plugins/rbenv-update" ]; then
#     print_warning "already cloned: rbenv-update"
#   else
#     git clone https://github.com/rkh/rbenv-update.git ~/.anyenv/envs/rbenv/plugins/rbenv-update
#   fi
# }

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
  install_brew_and_packages

  # setup_anyenv_rbenv
}

main
