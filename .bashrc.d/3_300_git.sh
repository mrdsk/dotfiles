# brew install gitすると自動で下記のディレクトリにリンクが貼られるはず
# 補完が有効になる、branch名が表示されるようになる
# なければここから落とす。https://github.com/git/git/tree/master/contrib/completion
if [ -d "/usr/local/etc/bash_completion.d/" ]; then
  . /usr/local/etc/bash_completion.d/git-prompt.sh
  . /usr/local/etc/bash_completion.d/git-completion.bash
  GIT_PS1_SHOWDIRTYSTATE=true
  export PS1='\h\[\033[00m\]:\W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
fi
