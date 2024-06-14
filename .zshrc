# Author: Dany Henriquez

# History configuration
export HISTFILE="$HOME/.zsh_history"  # Location of the history file
export HISTSIZE=10000                            # Maximum number of history events in memory
export SAVEHIST=$HISTSIZE                       # Number of history events to save to the history file

# Colors
eval "$(dircolors -b ~/.dircolors)"

# History options
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.

# Zsh options
setopt AUTO_CD                    # Change to a directory by typing its name
setopt AUTO_PUSHD                 # Automatically pushd upon changing directories
setopt PUSHD_IGNORE_DUPS          # Do not push multiple copies of the same directory onto the stack
setopt PUSHD_SILENT               # Do not print the directory stack after pushd or popd
setopt PUSHD_TO_HOME              # pushd with no arguments behaves as 'cd ~'
setopt CDABLE_VARS                # Change directory to a path stored in a variable
setopt CORRECT                    # Correct minor spelling errors in directory names
setopt CORRECT_ALL                # Correct spelling errors in all arguments
setopt GLOB_DOTS                  # Include hidden files in globbing
setopt NO_BEEP                    # Disable the beep on error
setopt NO_CASE_GLOB               # Case-insensitive globbing
setopt NO_NOMATCH                 # Do not generate an error if a glob doesn't match any files
setopt AUTO_LIST                  # Automatically list choices on ambiguous completion
setopt AUTO_MENU                  # Automatically use menu completion

# zstyle options for navigation
zstyle ':completion:*' menu select  # Enable menu selection for completions
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}  # Use LS_COLORS for completion coloring
zstyle ':completion:*:default' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'  # Prompt message
zstyle ':completion:*:descriptions' format '%B%d%b'  # Description formatting
zstyle ':completion:*:warnings' format '%B%F{red}No matches for: %d%b%f'  # Warning message formatting

# Key bindings for easier navigation
bindkey '^[[1;5C' forward-word  # Ctrl+Right to move forward by word
bindkey '^[[1;5D' backward-word  # Ctrl+Left to move backward by word
bindkey '^[[H' beginning-of-line  # Home to go to the beginning of the line
bindkey '^[[F' end-of-line  # End to go to the end of the line
bindkey '^[[3~' delete-char  # Delete to delete the character under the cursor
bindkey '^[[2~' overwrite-mode  # Insert to toggle overwrite mode

# Initialize Starship prompt
eval "$(starship init zsh)"

# Load Zsh Syntax Highlighting plugin
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Update PATH to include Go binaries
export PATH="$PATH:$(go env GOPATH)/bin"

# Initialize command completion
autoload -Uz compinit
compinit

# Aliases
# General Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias c="clear"
alias cl="clear; ls"

# File and Directory Operations
alias ls='ls --color=auto'
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias md="mkdir -p"
alias rd="rmdir"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias rmd="rm -rf"
alias du="du -h"
alias df="df -h"
alias h="history"

# Git
alias gst="git status"
alias ga="git add"
alias gaa="git add ."
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gb="git branch"
alias gl="git log"
alias gm="git merge"
alias gcl="git clone"

# Kubectl
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kgd="kubectl get deployments"
alias kgn="kubectl get nodes"
alias kge="kubectl get events"
alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"
alias kgc="kubectl config get-contexts"
alias kcc="kubectl config current-context"
alias ksc="kubectl config set-context"
alias kuc="kubectl config use-context"
alias kd="kubectl describe"
alias kl="kubectl logs"
alias kex="kubectl exec -it"
alias kpf="kubectl port-forward"
alias krun="kubectl run"
alias kapp="kubectl apply -k"
alias kdel="kubectl delete"
alias ke="kubectl edit"
alias ka="kubectl apply -f"

# Docker
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcb="docker-compose build"
alias dcr="docker-compose run"
alias dps="docker ps"
alias dexec="docker exec -it"
alias drm="docker rm"
alias drmi="docker rmi"
alias dlogs="docker logs"

# Network
alias myip="curl ifconfig.me"
alias ports="netstat -tulanp"
alias ping="ping -c 5"
alias wget="wget -c"
alias curl="curl -O"

# System Monitoring
alias top="htop"
alias meminfo="free -m -l -t"
alias psmem="ps auxf | sort -nr -k 4"
alias pscpu="ps auxf | sort -nr -k 3"

# Pacman
alias pacup="sudo pacman -Syu"
alias pacin="sudo pacman -S"
alias pacre="sudo pacman -R"
alias pacse="pacman -Ss"
alias pacli="pacman -Qi"
alias pacls="pacman -Qs"
alias pacrm="sudo pacman -Rns"
alias paccl="sudo pacman -Sc"
alias paccle="sudo pacman -Scc"
alias pacorph="sudo pacman -Rns $(pacman -Qdtq)"

# Yay
alias yayup="yay -Syu"
alias yayin="yay -S"
alias yayre="yay -R"
alias yayse="yay -Ss"
alias yayli="yay -Qi"
alias yayls="yay -Qs"
alias yayrm="yay -Rns"
alias yaycl="yay -Sc"
alias yaycle="yay -Scc"
alias yayorph="yay -Rns $(yay -Qdtq)"
# End aliases 

# NVM (Node Version Manager) configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Load nvm bash_completion
