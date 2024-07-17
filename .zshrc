# Author: Dany Henriquez
# Description: Zsh configuration

# History configuration
export HISTFILE="$HOME/.zsh_history"  # Location of the history file
export HISTSIZE=10000                            # Maximum number of history events in memory
export SAVEHIST=$HISTSIZE                       # Number of history events to save to the history file

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
zstyle ':completion:*:default' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*:descriptions' format '%B%d%b'  # Description formatting
zstyle ':completion:*:warnings' format '%B%F{red}No matches for: %d%b%f'  # Warning message formatting

# Key bindings for easier navigation
bindkey '^[[1;5C' forward-word  # Ctrl+Right to move forward by word
bindkey '^[[1;5D' backward-word  # Ctrl+Left to move backward by word
bindkey '^[[H' beginning-of-line  # Home to go to the beginning of the line
bindkey '^[[F' end-of-line  # End to go to the end of the line
bindkey '^[[3~' delete-char  # Delete to delete the character under the cursor
bindkey '^[[2~' overwrite-mode  # Insert to toggle overwrite mode

# Dircolors
if which dircolors &> /dev/null; then
    eval "$(dircolors -b ~/.dircolors)"
fi

if which gdircolors &>/dev/null; then
    eval "$(gdircolors -b ~/.dircolors)"
fi

# Load Zsh Syntax Highlighting plugin
if [ -f "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    source "$ZSH_SYNTAX_HIGHLIGHTING"
fi

if which brew &>/dev/null; then
    ZSH_SYNTAX_HIGHLIGHTING="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

    if [ -f "$ZSH_SYNTAX_HIGHLIGHTING" ]; then
        source "$ZSH_SYNTAX_HIGHLIGHTING"
    fi
fi

# Alias configuration
source "$HOME/.zshrc.aliases"

# Initialize Starship prompt
if which starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

# Update PATH to include Go binaries
if which go &> /dev/null; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi

# Initialize command completion
autoload -Uz compinit
compinit

# Set GVM_DIR variable
export GVM_DIR="$HOME/.gvm"

# Check if GVM_DIR directory exists and if gvm.sh is readable
if [ -d "$GVM_DIR" ] && [ -s "$GVM_DIR/scripts/gvm" ]; then
    # Load gvm.sh and setup chpwd hook for .go-version management
    source "$GVM_DIR/scripts/gvm"
    autoload -U add-zsh-hook
    add-zsh-hook chpwd load-go-version

    load-go-version() {
        local go_version_path="$PWD/.go-version"
        if [ -f "$go_version_path" ]; then
            local go_version=$(cat "$go_version_path")
            gvm use "$go_version"
        elif [ "$(gvm current)" != "$(gvm default)" ]; then
            gvm use default
        fi
    }
fi

# Set NVM_DIR variable
export NVM_DIR="$HOME/.nvm"

# Check if NVM_DIR directory exists and if nvm.sh is readable
if [ -d "$NVM_DIR" ] && [ -s "$NVM_DIR/nvm.sh" ]; then
    # Load nvm.sh and setup chpwd hook for .nvmrc management
    . "$NVM_DIR/nvm.sh"
    autoload -U add-zsh-hook
    add-zsh-hook chpwd load-nvmrc

    load-nvmrc() {
        local nvmrc_path="$(nvm_find_nvmrc)"
        if [ -f "$nvmrc_path" ]; then
            local nvmrc_version=$(cat "$nvmrc_path")
            [ "$(nvm version "$nvmrc_version")" = "N/A" ] && nvm install
            [ "$(nvm current)" != "$nvmrc_version" ] && nvm use
        elif [ "$(nvm current)" != "$(nvm version default)" ]; then
            nvm use default
        fi
    }
fi

# Check if bash_completion exists and is readable
if [ -s "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/bash_completion" # Load nvm bash_completion
fi
