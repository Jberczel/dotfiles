# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#alias ctags if you used homebrew
alias ctags="`brew --prefix`/bin/ctags"
alias dotfiles='/usr/bin/git --git-dir=/Users/jxberc/.dotfiles/ --work-tree=/Users/jxberc'
