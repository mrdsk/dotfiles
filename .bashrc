# .bashrc

# NOTE: .bash_profileと.bashrcの簡単な解説
#  - https://qiita.com/dark-space/items/cf25001f89c41341a9fd

# If you also want to write environment settings for each local
test -r ~/.bashrc_local  && . ~/.bashrc_local

if [ -d ~/.bashrc.d ]; then
  for i in ~/.bashrc.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
