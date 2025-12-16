#!/bin/bash

### See $ZDOTDIR/plugins-config/zsh-history-substring-search.sh
# bindkey "^P" up-line-or-beginning-search   # Up
# bindkey "^N" down-line-or-beginning-search # Down
# bindkey "\C-k" previous-history
# bindkey "\C-j" next-history

bindkey -v
bindkey "^R" history-incremental-pattern-search-backward
