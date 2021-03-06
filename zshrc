# -*- shell-script -*-
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# zsh completions
fpath=(~/.zsh/completion $fpath)

# docker completions?
autoload -Uz compinit && compinit -i

# Add python3 to path
# export PATH=$HOME/Library/Python/3.7/bin:$PATH

export PATH=/usr/local/Cellar/postgresql/11.1_1/bin:$PATH

# Secrets stuff
if [ -f '$HOME/.secrets.zsh.inc' ]; then source '$HOME/.secrets.zsh.inc'; fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions alias-tips kubetail)

source $ZSH/oh-my-zsh.sh

# gpg stuff
# git config --global commit.gpgsign true
# git config --global user.signingkey $KEY

function sign-and-send {
  gpg --sign-key "${1}" && gpg --send-keys "${1}"
}

alias pgz='gpg --list-secret-keys --keyid-format LONG'
alias pgr='gpg --recv-keys'
alias pgl='gpg --list-keys'
alias pgs='sign-and-send'

# git stuff
function git-task-types {
  echo "fix - bug patching"
  echo "feat - introducing a new feature"
  echo "test - adding tests"
  echo "perf - improving performance"
  echo "wip - placeholder tag signifying ongoing work"
  echo "deps - updating related to project dependencies"
  echo "docs - updating related to project documentation"
  echo "refactor - changing structure; functionality remains unchanged"
  echo "build - updating anything related to building and deploying"
}

function git-files() {
  commit="${1:-head}"
  git show --pretty="" --name-only "${commit}" | cat
}

function gh() {
    local file=`basename "$1"`
    local ext=${file##*.}

    git show "origin/master:${1}" | bat -l "${ext}" --paging always
}

function cd-git-head() {
  cd "$(git rev-parse --show-toplevel)"
}

function git-branch-delete-pattern() {
  git branch -D `git branch | grep -E ${1}`
}

function git-branch-checkout-pattern() {
  git checkout `git branch | grep -E ${1} | sed -n 1p`
}

function git-force-pull() {
  commit="${1:-$(git symbolic-ref --short HEAD)}"
  git fetch && git reset --hard origin/"${commit}"
}

alias git='hub'

alias gbdd='git branch -D'
alias gbdp='git-branch-delete-pattern'
alias gbm='git branch --merged'
alias gcan='git commit --no-edit --amend'
alias gcop='git-branch-checkout-pattern'
alias gdh='git diff head~ head'
alias gds='git diff --staged'
alias gfl='git-files'
alias gfx='git commit --fixup'
alias gi='git init'
alias glf='git-force-pull'
alias glfm='git fetch && git reset --hard origin/master'
alias glp="git log --graph --pretty=format:'%Cred%h%Creset -%Cblue %an %Creset - %C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gpf='git push --force'
alias gpop='git reset head~'
alias gpr='git pull-request'
alias gprom='git fetch && git pull --rebase origin master'
alias gpu='git push -u origin "$(git symbolic-ref --short HEAD)"'
alias grhr='git reset --hard'
alias gril='rm .git/index.lock'
alias gsbu='git status -sbu'
alias gsn='git add .; git commit --no-verify -m "wip"; git reset head~'
alias gtt='git-task-types'
alias pulls='open "https://github.com:/$(git remote -v | /usr/bin/grep -oP "(?<=git@github.com:).+(?=\.git)" | head -n 1)/pulls"'
alias ghsh="git rev-parse --short head"

alias cdg='cd-git-head'

# tmux functions
function tt() {
  sessionName="${1}"
  if ! tmux has-session -t "${sessionName}" 2> /dev/null; then
    oldTMUX="${TMUX}"
    unset TMUX
    tmux new -d -s "${sessionName}"
    export TMUX="${oldTMUX}"
    unset oldTMUX
  fi
  if [[ -n "${TMUX}" ]]; then
    tmux switch-client -t "${sessionName}"
  else
    tmux attach -t "${sessionName}"
  fi
}

alias tls='tmux list-sessions'

# fzf things
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# key repeat speed up
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 20

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then source '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then source '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# shell aliases
alias zz='source ~/.zshrc'
alias ls='exa'
alias ll='exa -l'
alias la='exa -la'

# python aliases
function python-shell() {
  pkgs=`echo 'python37.withPackages(ps: with ps; [ '$@' ])'`
  nix-shell -p $pkgs --run python3
}
alias py='python-shell'
alias ptw="pipenv run watchmedo auto-restart --recursive -p '*.py' -- python -m pytest grid/jobs/tests --show-capture=all"
alias pei='pipenv install --dev'
alias pesy='pipenv sync --dev'
alias pes='pipenv shell'
alias pyf='pipenv run yapf --in-place --recursive .'
alias pmy='pipenv run alembic upgrade head'
alias auh='alembic upgrade head'
alias amg='alembic revision -m'

# drone env variables
export DRONE_TOKEN=$DRONE_TOKEN_PRIVATE
export DRONE_SERVER=https://ci.urbinternal.com

# stack Haskell path add
export PATH=$PATH:$HOME/.local/bin

# cabal path add
export PATH=$PATH:$HOME/.cabal/bin

# anaconda path add
export PATH=$PATH:~/anaconda/bin

# haskell aliases
function stack-watch-test-pattern() {
  pattern="${1:-}"
  stack test --file-watch grid:grid-test --ta "-p ${pattern}"
}

function stack-watch-test-path() {
  pattern="${1:-}"
  ghcid -c "stack ghci grid:lib grid:grid-test --ghci-options=-fobject-code" --height=$(tput lines) --width=$(tput cols) --warnings --test "${pattern}" | source-highlight -s haskell -f esc
}

alias hs='stack ghci'
alias sb='stack build'
alias sben='stack bench --no-run-benchmarks --pedantic --ghc-options -Wno-missing-home-modules'
alias sp='stack build --pedantic'
alias st='stack test grid:grid-test --ta "--hedgehog-tests 5"'
alias std='stack test grid:doctests'
alias stl='stack test'
# alias stw='stack test grid:grid-test --file-watch --ta "--hedgehog-tests 5"'
alias stw='TASTY_HEDGEHOG_TESTS=5 ghcid -c "stack ghci grid:lib grid:grid-test --ghci-options=-fobject-code" --warnings --test "Main.main" | source-highlight -s haskell -f esc'
alias stwp='stack-watch-test-pattern'
alias stwpth='stack-watch-test-path'
alias sbt="stack build --file-watch --test --test-arguments '--rerun --failure-report=TESTREPORT --rerun-all-on-success'"
alias sbw='ghcid -c "stack ghci --main-is grid:lib grid:grid-test grid:grid-bench" --height=$(tput lines) --width=$(tput cols) | source-highlight -s haskell -f esc'
alias sd='stack clean && stack test --pedantic --ghc-options -Wno-missing-home-modules --ta "--hedgehog-tests 5" && stack bench --no-run-benchmarks --pedantic --ghc-options -Wno-missing-home-modules  && stack build --pedantic && stack exec -- hlint src test app'
alias sds='stack test --pedantic --ghc-options -Wno-missing-home-modules --ta "--hedgehog-tests 5" && stack bench --no-run-benchmarks --pedantic --ghc-options -Wno-missing-home-modules && stack build --pedantic && stack exec -- hlint src test app'
alias shl='stack exec -- hlint src test app'
alias s='stack'

# cabal stuff
alias cbw='ghcid -c "cabal repl lib:bobby" --height=$(tput lines) --width=$(tput cols) | source-highlight -s haskell -f esc'

# nix stuff
function nix-shell-haskell() {
  # Creates a nix-shell with the specified arguments as Haskell packages
  nix-shell -p "haskellPackages.ghcWithPackages (p: with p; [$@])"
}

function nix-query () {
  local CACHE="$HOME/.cache/nq-cache"
  if ! ( [ -e $CACHE ] && [ $(stat -c %Y $CACHE) -gt $(( $(date +%s) - 3600 )) ] ); then
    echo "update cache" && nix-env -qa --json > "$CACHE"
  fi
  jq -r 'to_entries | .[] | .key + "|" + .value.meta.description' < "$CACHE" |
    {
       if [ $# -gt 0 ]; then
          # double grep because coloring breaks column's char count
          # $* so that we include spaces (could do .* instead?)
            grep -i "$*" | column -t -s "|" | grep --color=always -i "$*"
       else
            column -t -s "|"
       fi
    }
}

source $HOME/.nix-profile/etc/profile.d/nix.sh
export NIX_PATH=darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$HOME/.nix-defexpr/channels:$NIX_PATH
export NIX_PATH=darwin=$HOME/.nix-defexpr/channels/darwin:$NIX_PATH
# Add darwin-nix to path
export PATH=$(nix-build '<darwin>' -A system --no-out-link)/sw/bin/:$PATH

alias nsh='nix-shell-haskell'
alias nrp="nix repl '<nixpkgs>'"
alias nb='nix-build'
alias ne='nix-env'
alias nhash='nix-prefetch-url --type sha256'
alias nq='nix-query'
alias nqu='NIXPKGS_ALLOW_UNFREE=1 nix-env -qaP'
alias nr='nix repl'
alias ns='nix-shell'
alias nsu="nix-shell --arg nixpkgs 'import <nixpkgs-unstable> {}'"
alias nsp='nix-shell -p'
alias nst='nix-store'
alias nsref='nix-store-references'
alias nsrefr='nix-store-referrers'
alias ndeps='nix-store-deps'
alias ndtree='nix-store-deps-tree'
alias nstp='nix-store-path'
alias dxs='darwin-rebuild switch'
alias nl='nix-env -q'
alias nxs='cd ~ && sudo nixos-rebuild switch; cd -'
alias nxsr='cd ~ && sudo nixos-rebuild switch && sudo reboot'
alias nxt='cd ~ && sudo nixos-rebuild test; cd -'

# grid-client aliases
alias pretty='npx prettier --write "./src/**/*.js"'

# grid aliases
alias rmdb='rm -rf data/graph.db'

# urbint/<project-name>/scripts/* compliant aliases
alias xs="scripts/start"
alias xup="scripts/setup"
alias xt="scripts/test"
alias xb="scripts/bootstrap"
alias xdoc="scripts/docs"

# emacs stuff
alias emd='emacs --debug-init'

# chunkwm utility
function upgrade-chunkwm() {
    brew reinstall --HEAD chunkwm
    codesign -fs "chunkwm-cert" $(brew --prefix chunkwm)/bin/chunkwm
    brew services restart chunkwm
}
alias uch='upgrade-chunkwm'


# shell stuff
alias cat='bat'

# slack dark thenme
function dark-slack() {

echo "\ndocument.addEventListener('DOMContentLoaded', function() {
 $.ajax({
   url: 'https://cdn.rawgit.com/laCour/slack-night-mode/master/css/raw/black.css',
   success: function(css) {
     \$(\"<style></style>\").appendTo('head').html(css);
   }
 });
});" >> /Applications/Slack.app/Contents/Resources/app.asar.unpacked/src/static/ssb-interop.js
}

# docker
function docker-restart-and-log() {
  docker-compose restart "$1" && docker-compose logs -f "$1"
}

alias dcud='docker-compose up -d'
alias dclf='docker-compose logs -f'
alias dc='docker-compose'
alias dcub='docker-compose up --build -d'
alias dcr='docker-compose restart'
alias dps='docker ps'
alias dsac='docker stop $(docker ps -aq)'
alias drac='docker rm $(docker ps -aq)'
alias dcrf="docker-restart-and-log"
alias dcrb="docker-compose restart server internal_server celery celery-beat celery-process-video celery-classify-frames celery-upload-video-to-gcs"
alias dclb="docker-compose logs -f server internal_server celery celery-beat celery-process-video celery-classify-frames celery-upload-video-to-gcs"
alias drni="docker rmi $(docker images | grep '^<none>' | awk '{print $3}')"
alias drdi="docker rmi $(docker images -q -f "dangling=true")"
alias drmc="docker rm $(docker ps -q -f 'status=exited')"

function kpods-by-app() {
  kubectl get pods --selector="app=${1}"
}

# kubernetes
alias kc='kubectl'
alias kt='kubetail'
alias klj='kubetail grid-jobs'
alias kls='kubetail server'
alias klb='kubetail "grid-(server|jobs|celery\S*)" --regex'
alias kp='kubectl get pods'
alias kpn='kpods-by-app'
alias kdys='kubectl get deployments'
alias ksrvs='kubectl get services'
alias kpw='kubectl get pods -w'
alias klf='kubectl logs -f'
alias gclc='gcloud container clusters get-credentials' # followed by the cluster name

# grid
alias gcyp='(cd ~/projects/urbint/grid && ./scripts/cypress.sh open)'

# xndr
alias xndr='~/projects/xndr/dist/build/xndr/xndr'
