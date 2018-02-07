#!/bin/bash

for f in .??*
do
  [[ $f == .git ]] && continue
  test -r ~/${f}   && continue

  ln -s ~/.dotfiles/${f} ~/${f}
done
