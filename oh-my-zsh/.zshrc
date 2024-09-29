# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-sh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git sudo zsh-syntax-highlighting zsh-autosuggestions you-should-use zsh-fzf-history-search)

source $ZSH/oh-my-zsh.sh

# User configuration

#  ╭──────────────────────────────────────────────────────────╮
#  │ Eval                                                     │
#  ╰──────────────────────────────────────────────────────────╯
eval "$(rbenv init - zsh)"
eval "$(zoxide init zsh)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# fnm
eval "$(fnm env)"
# automatically load ssh keys into the ssh-agent and store passphrases in your keychain on reboot (macOS)
eval "$(ssh-add --apple-use-keychain ~/.ssh/id_rsa 2> /dev/null)"
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# ╭──────────────────────────────────────────────────────────╮
# │ fzf                                                      │
# ╰──────────────────────────────────────────────────────────╯
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

#  ╭──────────────────────────────────────────────────────────╮
#  │ Aliases                                                  │
#  ╰──────────────────────────────────────────────────────────╯
alias sozsh="source ~/.zshrc"

alias v="neovide --no-multigrid &"
# alias v="nvim --listen /tmp/nvimsocket"
alias vi="nvim"
alias vim="nvim"

alias l="eza -lA --icons=auto --git"
alias ls="eza --icons=auto --git"
alias lt="eza --tree --level=2 --long --icons --git"
alias lg="lazygit"
alias icat="kitty +kitten icat"
alias iosdevices="xcrun xctrace list devices"
alias pn=pnpm
alias emulator="emulator -avd Pixel_6_Pro_API_31"
alias gpge="gpg --encrypt --sign --armor -r"
alias yd="yarn dev"
alias y="yazi"
alias ghcs="gh copilot suggest"

# I'm retarded so I need this
alias :q='exit'
alias :wq='exit'

#  ╭──────────────────────────────────────────────────────────╮
#  │ Functions                                                │
#  ╰──────────────────────────────────────────────────────────╯
function ya() {
    tmp="$(mktemp -t "yazi-cwd.XXXXX")"
    yazi --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Sketchybar interactivity overloads
function brew() {
  command brew "$@" 

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

function update-wezterm () {
  brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest
}

# GaiaLens
gl_add_network() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: gl_add_network INSTANCE_NAME IP_NAME"
    return 1
  fi

  local project_id=gaialens-300
  local instance_name="$1"
  local name="$2"

  # Get an access token for authentication
  local access_token=$(gcloud auth print-access-token)

  # Get the public IP of the current machine
  local new_ip=$(curl -s ipinfo.io/ip)

  # Validate the IP address
  if [[ -z "$new_ip" || ! "$new_ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: Invalid or empty IP address."
    return 1
  fi

  # Fetch existing authorized networks
  local existing_networks=$(curl -s \
    "https://sqladmin.googleapis.com/sql/v1beta4/projects/$project_id/instances/$instance_name?fields=settings/ipConfiguration/authorizedNetworks" \
    -H "Authorization: Bearer $access_token")

  local updated_networks="$existing_networks"
  # Check if an entry with the same name exists
  local existing_entry=$(echo $existing_networks | jq -r --arg name "$name" '.settings.ipConfiguration.authorizedNetworks[] | select(.name == $name)')

  if [ -n "$existing_entry" ]; then
    # Update the existing entry
    updated_networks=$(echo $existing_networks | jq --arg name "$name" --arg ip "$new_ip" \
                       '.settings.ipConfiguration.authorizedNetworks |= map(if .name == $name then .value = $ip else . end)')
  else
    # Prepare the new network entry
    local new_entry="{\"kind\": \"sql#aclEntry\", \"name\": \"$name\", \"value\": \"$new_ip\"}"

    # Add the new entry to the existing list
    updated_networks=$(echo $existing_networks | jq --argjson new_entry "$new_entry" \
                       '.settings.ipConfiguration.authorizedNetworks += [$new_entry]')
  fi

  echo "Your IP address is $new_ip"

  # Update the Cloud SQL instance with the modified authorized networks
  curl -X PATCH \
    -H "Authorization: Bearer $access_token" \
    -H "Content-Type: application/json" \
    -d "$updated_networks" \
    "https://sqladmin.googleapis.com/sql/v1beta4/projects/$project_id/instances/$instance_name"
}

# https://egeek.me/2020/04/18/enabling-locate-on-osx/
if which glocate > /dev/null; then
  alias locate="glocate -d $HOME/locatedb"

  # Using cache_list requires `LOCATE_PATH` environment var to exist in session.
  # trouble shoot: `echo $LOCATE_PATH` needs to return db path.
  [[ -f "$HOME/locatedb" ]] && export LOCATE_PATH="$HOME/locatedb"
fi

alias loaddb="gupdatedb --localpaths=$HOME --prunepaths=/Volumes --output=$HOME/locatedb"


#  ╭──────────────────────────────────────────────────────────╮
#  │ Exports                                                  │
#  ╰──────────────────────────────────────────────────────────╯

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export GPG_TTY=$(tty)
export OPENAI_API_KEY=$(pass show secrets/open-api-key)
export VISUAL="nvim"
export EDITOR="nvim"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
# pnpm
export PNPM_HOME="/Users/lukasz.kurpiewski/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# bun completions
[ -s "/Users/lukasz.kurpiewski/.bun/_bun" ] && source "/Users/lukasz.kurpiewski/.bun/_bun"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# fnm
export PATH="/Users/lukasz.kurpiewski/Library/Caches/fnm_multishells/68052_1679473264013/bin":$PATH
export FNM_ARCH="arm64"
export FNM_MULTISHELL_PATH="/Users/lukasz.kurpiewski/Library/Caches/fnm_multishells/68052_1679473264013"
export FNM_LOGLEVEL="info"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="/Users/lukasz.kurpiewski/Library/Application Support/fnm"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
rehash

# automatically load ssh keys into the ssh-agent and store passphrases in your keychain on reboot
ssh-add --apple-use-keychain ~/.ssh/id_rsa 2> /dev/null

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
