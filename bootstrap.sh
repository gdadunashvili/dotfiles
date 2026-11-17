#! /bin/bash

# Create symlinks to the dotfiles in this directory based on a specific set.
# Usage: ./bootstrap.sh <set>


# Sets:


make_backup_dir(){
    if [ ! -d "$backup_dir" ]; then
        echo "Creating backup directory $backup_dir to store existing files"
        mkdir -p $backup_dir
    fi
}

install_keymaps(){
    source_file="config/keyd/default.conf"
    target="/etc/keyd/default.conf"
    if [ -h $target ]; then
        echo "Deleting old symlink"
        sudo rm $target
    fi

    make_backup_dir
    # If it is a file, back it up if not already done so
    if [ -f $target ] && [ -d $backup_dir ]; then
        echo "Backing up existing file"
        cp -i $target $backup_dir/
    fi

    echo $PWD/$source_file
    sudo ln -s $PWD/$source_file $target
    sudo keyd reload
}

set_editor="config/nvim editorconfig"

# Typicall full workstation, not including any window manager
set_full="zshrc aliases destinations editorconfig tmux.conf ideavimrc shell_prompt.sh config/starship.toml \
config/nvim editorconfig config/kitty git-templates fonts config/ranger config/keymapper.conf"

# Git templates to generate ctag files automatically
set_git_template="git-templates"

set_fonts="fonts"

# Use the directory containing this script as absolute path for the symlinks
# Backup existing dotfiles to this directory before replacing them
backup_dir=~/.dotfiles_old

install_files() {
    local install=$1
    for file in $install; do
        echo "Processing ~/.$file"

        # If there is already a symlink there, delete it
        if [ -h ~/."$file" ]; then
            echo "Deleting old symlink"
            rm ~/."$file"
        fi

        # If it is a file, back it up if not already done so
        if [ -f ~/."$file" ] && [ -d $backup_dir ]; then
            echo "Backing up existing file"
            mv -i ~/."$file" $backup_dir/
        fi

        # Create the directory the symlink is going to be in
        directory=$(dirname ~/."$file")
        if [ ! -d "$directory" ] ; then
            echo "Creating missing directory $directory"
            mkdir -p "$directory"
        fi

        echo "Creating symlinks"
        ln -s "$PWD/$file" ~/."$file"
        echo ""
    done
}

configure_git_templates(){
        git config --global init.templateDir "$HOME"/."$set_git_template"
}

case "$1" in
    full)
        install_files "$set_full"
        configure_git_templates
        ;;
    editor)
        install_files "$set_editor"
        ;;
    git_template)
        install_files "$set_git_template"
        configure_git_templates
        ;;
    fonts)
        install_files "$set_fonts"
        ;;
    *)
        echo -e "Usage: bootstrap.sh <set>\n"
        echo -e "Available sets:\n"
        echo -e "full:\n$set_full\n"
        echo -e "editor:\n$set_editor\n"
        echo -e "git_template:\nSetup git templates for git\n"
        echo -e "fonts:\nSetup a few nerdfonts\n"
        exit 1;;
esac


make_backup_dir

