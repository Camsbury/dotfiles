
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
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

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

# gpg stuff
# git config --global commit.gpgsign true
# git config --global user.signingkey $KEY
alias myg='gpg --list-secret-keys --keyid-format LONG'

alias git='hub'

alias gbdd='git branch -D'
alias gbm='git branch --merged'
alias gcan='git commit --no-edit --amend'
alias gdh='git diff head~ head'
alias gds='git diff --staged'
alias gfl='git-files'
alias gfx='git commit --fixup'
alias gi='git init'
alias glp="git log --graph --pretty=format:'%Cred%h%Creset -%Cblue %an %Creset - %C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gpf='git push --force'
alias gpop='git reset head~'
alias gpr='git pull-request'
alias gprom='git pull --rebase origin master'
alias gpu='git push -u origin "$(git symbolic-ref --short HEAD)"'
alias grhr='git reset --hard'
alias gril='rm .git/index.lock'
alias gsbu='git status -sbu'
alias gsn='git add .; git commit --no-verify -m "wip"; git reset head~'
alias gtt='git-task-types'
alias pulls='open "https://github.com:/$(git remote -v | /usr/bin/grep -oP "(?<=git@github.com:).+(?=\.git)" | head -n 1)/pulls"'

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

# mix aliases
alias tism='MIX_ENV=test iex -S mix'
alias ism='iex -S mix'
alias mdg='mix deps.get'
alias max='cd ~/projects/urbint/machina/ && iex -S mix && cd -'
alias madb='rm -rf data/*db data/test/*db'
alias mxc='mix credo --strict'
alias mxd='mix dialyzer --halt-exit-status'
alias mcmp='mix compile --force --warnings-as-errors'
alias mpost='docker rm machina-postgres && mix docker.up'
alias mem='mix ecto.migrate'
alias tmem='MIX_ENV=test mix ecto.migrate'

# iex stuff
export ERL_AFLAGS="-kernel shell_history enabled"

# shell aliases
alias zz='source ~/.zshrc'

# python aliases
alias py='python'
alias py3='python3'

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

alias hs='stack ghci'
alias sb='stack build'
alias sp='stack build --pedantic'
alias st='stack test --ta "--hedgehog-tests 5"'
alias stl='stack test'
alias stw='stack test --file-watch --ta "--hedgehog-tests 5"'
alias stwp='stack-watch-test-pattern'
alias sbt="stack build --file-watch --test --test-arguments '--rerun --failure-report=TESTREPORT --rerun-all-on-success'"
alias sbw='ghcid -c "stack ghci" | source-highlight -s haskell -f esc'
alias sd='stack clean && stack test --pedantic --ghc-options -Wno-missing-home-modules --ta "--hedgehog-tests 5" && stack build --pedantic && stack exec -- hlint src test app'
alias sds='stack test --pedantic --ghc-options -Wno-missing-home-modules --ta "--hedgehog-tests 5" && stack build --pedantic && stack exec -- hlint src test app'
alias shl='stack exec -- hlint src test app'

# grid-client aliases
alias pretty='npx prettier --write "./src/**/*.js"'

# grid aliases
alias rmdb='rm -rf data/graph.db'

# emacs stuff
alias emd='emacs --debug-init'

# chunkwm utility
function upgrade-chunkwm() {
    brew reinstall --HEAD chunkwm
    codesign -fs "chunkwm-cert" $(brew --prefix chunkwm)/bin/chunkwm
    brew services restart chunkwm
}
alias uch='upgrade-chunkwm'
