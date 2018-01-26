#!/bin/bash

for f in .??*
do
  [[ $f == .git ]] && continue

  ln -s ~/.dotfiles/${f} ~/${f}
done
