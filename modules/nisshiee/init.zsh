#
# Secrets
#
if [ -r ~/.secrets ]; then
  source ~/.secrets
fi

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
if [ -z "$HOMEBREW_GITHUB_API_TOKEN" ]; then
  echo "Create a new personal access token:"
  echo "-> https://github.com/settings/tokens/new?scopes=gist,public_repo&description=Homebrew"
  echo "-> write export to ~/.secrets"
fi

#
# nodenv
#
eval "$(nodenv init -)"

# Python
#   - Python2.7はmacOS Syste
#       - python get-pip.py --user でpipがインストールされている
#   - Python3系はPython本家サイトからインストーラをダウンロードしてインストール
PATH="/Users/nisshiee/Library/Python/2.7/bin:/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
