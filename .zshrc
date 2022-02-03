# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ecosse/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions you-should-use zsh-z vi-mode)

source $ZSH/oh-my-zsh.sh

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

# For a full list of active aliases, run `alias`.
#
# Aliases
alias sozsh="source ~/.zshrc"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias snap="snap"
alias snpm="sudo npm"
alias l="colorls -lA --sd"
alias ls="colorls"
alias lg="lazygit"
alias clear_teams_cache="rm -rf Application\ Cache/Cache/* blob_storage/* Cache/* Code\ Cache/js/* databases/* GPUCache/* IndexedDB/* Local\ Storage/*"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias ssh="kitty +kitten ssh"

# I'm retarded so I need this
alias :q='exit'
alias :wq='exit'

# React Native
alias rn="npx react-native"
alias rns="npx react-native start"
alias rnscc="npx react-native start --reset-cache"
alias rnand="npx react-native run-android"
alias rnland="npx react-native log-android"
alias rnios="npx react-native run-ios"
alias rnlios="npx react-native log-ios"
alias rnemulator="emulator -avd Pixel_XL_API_30"


# Sources

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(keychain --eval --quiet id_rsa)


# Custom commands

# search and install packages with fzf
yi() {
	SELECTED_PKGS="$(yay -Slq | fzf --header='Install packages' -m --preview 'yay -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		yay -S $(echo $SELECTED_PKGS)
	fi
}

# search and remove packages with fzf
yr() {
	SELECTED_PKGS="$(yay -Qsq | fzf --header='Remove packages' -m --preview 'yay -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		yay -Rns $(echo $SELECTED_PKGS)
	fi
}

# remove unneeded packages
autoremove() { sudo pacman -Rns $(pacman -Qdtq) }

# colorls
source $(dirname $(gem which colorls))/tab_complete.sh

# nvm
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/bash_completion
source /usr/share/nvm/install-nvm-exec

# calling nvm use automatically in directory with a .nvmrc file
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Find SSH agent automatically
~/.scripts/ssh-find-agent.sh -a
if [ -z "$SSH_AUTH_SOCK" ]
then
   eval $(ssh-agent) > /dev/null
   ssh-add -l >/dev/null || alias ssh='ssh-add -l >/dev/null || ssh-add && unalias ssh; ssh'
fi

# PATHs
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="/home/ecosse/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$PATH:$(yarn global bin)"
export GOPATH="$HOME/go"
export GOROOT="/usr/lib/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export KEYTIMEOUT=30


# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/ecosse/.sdkman"
[[ -s "/home/ecosse/.sdkman/bin/sdkman-init.sh" ]] && source "/home/ecosse/.sdkman/bin/sdkman-init.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
