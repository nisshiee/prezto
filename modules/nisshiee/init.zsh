#
# Prompt
#
PROMPT='${editor_info[keymap]} '
TRAPALRM () { zle reset-prompt }
TMOUT=30

# Docker
alias dm=docker-machine
alias dc=docker-compose

# PATH
path=(
  $HOME/bin
  /usr/local/opt/coreutils/libexec/gnubin
  /usr/local/opt/findutils/libexec/gnubin
  $path
)
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/usr/local/opt/findutils/libexec/gnuman:$MANPATH"

#
# Aliases
#
alias gk='stree'
alias gf='git fetch --all -p && git fetch origin master:master && git fetch origin develop:develop'
alias gpl='git fetch --all -p && git co master && git pull'
alias gdt='git difftool -y'
alias gbp='git branch --merged master | grep -v master | xargs git branch -d'
alias gn='git now'
alias sed=gsed
alias tree='tree -C'
alias fs='foreman start'
alias netstat='lsof -nP -iTCP -sTCP:LISTEN'
alias be='bundle exec'

#
# ruby
#
eval "$(rbenv init -)"

#
# direnv
#
eval "$(direnv hook zsh)"

#
# peco
#
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#
# enhancd
#
if [ -f "${HOME}/.enhancd/init.sh" ]; then
    source "${HOME}/.enhancd/init.sh"
fi

#
# rust
#
export PATH="$HOME/.cargo/bin:$PATH"

#
# golang
#
export GOPATH="$HOME"

#
# Github
#
function gpr() {
  local current_branch_name=$(git symbolic-ref --short HEAD | xargs perl -MURI::Escape -e 'print uri_escape($ARGV[0]);')
  hub browse -- pull/${current_branch_name}
}

#
# Homebrew
#
export HOMEBREW_GITHUB_API_TOKEN=8cfcf85ad22d360a207949f8f26978982ae6780a

#
# nodenv
#
eval "$(nodenv init -)"
