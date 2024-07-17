
# Author: Dany Henriquez
# Description: Script to symlink dotfiles and configs

# Set DOTFILES_DIR to current working directory
DOTFILES_DIR="$(pwd)"

# Array of dotfiles and config files to symlink
files=(
    "$DOTFILES_DIR/.zshrc:$HOME/.zshrc"
    "$DOTFILES_DIR/.zshrc.aliases:$HOME/.zshrc.aliases"
    "$DOTFILES_DIR/.dircolors:$HOME/.dircolors"
    "$DOTFILES_DIR/.config/starship.toml:$HOME/.config/starship.toml"
)

# Function to create symlinks
create_symlink() {
    local source_file=$1
    local target_file=$2

    # Check if the target file already exists
    if [ -e "$target_file" ]; then
        read -p "Target file '$target_file' already exists. Do you want to replace it? (y/n): " replace_choice
        case "$replace_choice" in
        y | Y)
            echo "Replacing existing $target_file"
            rm -rf "$target_file"
            ln -s "$source_file" "$target_file"
            ;;
        n | N)
            echo "Skipping $target_file"
            ;;
        *)
            echo "Invalid choice. Skipping $target_file"
            ;;
        esac
    else
        # Create the symlink if the target file doesn't exist
        echo "Creating symlink: $target_file -> $source_file"
        ln -s "$source_file" "$target_file"
    fi
}

# Function to install dotfiles
install() {
    for file in "${files[@]}"; do
        source_file="${file%%:*}" # Extract source file from "source:target"
        target_file="${file#*:}"  # Extract target file from "source:target"

        # Ensure the target directory exists
        target_dir=$(dirname "$target_file")
        if [ ! -d "$target_dir" ]; then
            echo "Creating directory: $target_dir"
            mkdir -p "$target_dir"
        fi

        # Create the symlink
        create_symlink "$source_file" "$target_file"
    done

    echo "Installation complete."
}

install
