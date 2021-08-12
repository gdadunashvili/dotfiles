#! /bin/sh

# Create symlinks to the dotfiles in this directory based on a specific set.
# Usage: ./bootstrap.sh <set>


# Sets:

# Smallest setup to work with
set_basic="bash_profile shell_prompt.sh aliases destinations"

# Typicall full workstation, not including any window manager
set_full="bashrc zshrc tmux.conf shell_prompt.sh aliases p10k.zsh destinations vim/vimrc \
config/nvim/init.vim latexmkrc git_template mpvfire ydlfire time_math.sh qrdisplay"

# Git templates to generate ctag files automatically
set_git_template="git_template"

# WM
set_bspwm="config/bspwm/ config/sxhkd"
set_awesome="config/awesome/"


# Use the directory containing this script as absolute path for the symlinks
# dotfile_dir= $PWD
# $(dirname $(readlink -f "$0"))
# Backup existing dotfiles to this directory before replacing them
backup_dir=~/.dotfiles_old


case "$1" in
    full)
        install=$set_full
        git config --global init.templatedir '~/.git_template'
        ;;
    basic)
        install=$set_basic;;
    git_template)
        install=$set_git_template
        git config --global init.templatedir '~/.git_template'
        ;;
    bspwm)
        install=$set_bspwm;;
    awesome)
        install=$awesome;;
    *)
        echo -e "Usage: bootstrap.sh <set>\n"
        echo -e "Available sets:\n"
        echo -e "full:\n$set_full\n"
        echo -e "basic:\n$set_basic\n"
        echo -e "git_template:\nSetup git templates for ctags\n"
        echo -e "bspwm:\nSetup bspwm and lemonbar-xft\n"
        echo -e "awesome:\nSetup awesome"
        exit 1;;
esac


if [ ! -d "$backup_dir" ]; then
    echo "Creating backup directory $backup_dir to store existing files"
    mkdir -p $backup_dir
fi


for file in $install; do
    echo "Processing ~/.$file"

    # If there is already a symlink there, delete it
    if [ -h ~/.$file ]; then
        echo "Deleting old symlink"
        rm ~/.$file
    fi

    # If it is a file, back it up if not already done so
    if [ -f ~/.$file ] && [ -d $backup_dir ]; then
        echo "Backing up existing file"
        mv -i ~/.$file $backup_dir/
    fi

    # Create the directory the symlink is going to be in
    directory=$(dirname ~/.$file)
    if [ ! -d $directory ] ; then
        echo "Creating missing directory $directory"
        mkdir -p $directory
    fi

    # echo "Creating symlinks"
    echo "copying files"
    cp -v $PWD/$file ~/.$file
    echo ""
done
