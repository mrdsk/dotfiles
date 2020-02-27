# .bash_history settings
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%Y-%m-%d %T '

##########
#
# historyをターミナル間で共有するための設定
#
#####
share_history() {
  history -a # .bash_historyに前回コマンドを1行追記
  history -c # 端末ローカルの履歴を一旦消去
  history -r # .bash_historyから履歴を読み込み直す
}

PROMPT_COMMAND='share_history' # 上記関数をプロンプト毎に自動実施
shopt -u histappend # .bash_history追記モードは不要なのでOFFに

if [ ! -s "$HOME/.bash_history" ]; then
  # 初回ログオン時にhistoryファイルがないと作成されないことへの対策
  echo 'history' > "$HOME/.bash_history"
  chmod 600 "$HOME/.bash_history"
else
  # This is a trick for working natural when number of command history
  # got lager than $HISTSIZE.
  # In this case, history command shows history number from not 1.
  # One commnad history uses 2 lines. So for 'tail' usage, $HISTSIZE should be twice you want.
  # And this provides buffer for commnd list on line.
  # So number of history never gets over $HISTSIZE.
  tail -n $HISTSIZE "$HOME/.bash_history" > "$HOME/.bash_history.$$"
  cat "$HOME/.bash_history.$$" > "$HOME/.bash_history"
  rm  "$HOME/.bash_history.$$"
fi
#####
#
# historyをターミナル間で共有するための設定
#
##########
