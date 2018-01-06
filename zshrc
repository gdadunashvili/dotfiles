# Completion  ------------------------------------------------------{{{
autoload -Uz compinit
compinit

# Just print the possible completions without completing the first one
zstyle ':completion:*' menu auto
# Completion is always inserted completely, press tab for the next
setopt MENU_COMPLETE
# If glob can't find anything in the directory, it passes the glob to
# the invoking program to handle it
setopt NO_NOMATCH
# Use extended globbing
setopt EXTENDEDGLOB
# Typo correction
setopt CORRECT
# Text for correction-prompt
SPROMPT="Correct '%R' to '%r' ? ([Y]es/[N]o)"
# Case insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# Do not beep
setopt NO_BEEP
# ------------------------------------------------------------------}}}

# History  ---------------------------------------------------------{{{
# Save your history in this file
HISTFILE=~/.histfile
# Lines of history in the shell
HISTSIZE=20000
# Lines of history to save to the histfile
SAVEHIST=20000
# Ignore duplicate lines in the history for writing to the histfile
setopt HIST_SAVE_NO_DUPS
# Searching the history entries, do not display duplicates
setopt HIST_FIND_NO_DUPS
# Don't add any command starting with a space to the history
setopt HIST_IGNORE_SPACE
# Add to history right after they are entered
setopt INC_APPEND_HISTORY
# Share history between terminals
setopt SHARE_HISTORY
# ------------------------------------------------------------------}}}

# Keybindings  -----------------------------------------------------{{{
# Use vi-bindings
bindkey -v
# Go to normal mode with jk (in addition to jj)
bindkey -M viins 'jk' vi-cmd-mode
# Enable back-i-search with ctrl-r
bindkey "^R" history-incremental-search-backward
# ------------------------------------------------------------------}}}

# Colors  ----------------------------------------------------------{{{
autoload -U colors
colors

# Enable colored output from ls, etc.
export CLICOLOR=1
# Set colors
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=30;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Enable syntax-highlighting
if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	ZSH_HIGHLIGHT_STYLES[path]=none
	# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
	ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow'
fi
# ------------------------------------------------------------------}}}

# Prompt  ----------------------------------------------------------{{{
autoload -U promptinit
promptinit
setopt prompt_subst
# Load airline prompt. Generate from vim :PromptlineSnapshot ~/.shell_prompt.sh
[[ -f ~/.shell_prompt.sh ]] && source ~/.shell_prompt.sh
# ------------------------------------------------------------------}}}

# Open default  ----------------------------------------------------{{{
# If you don't specify a program, but enter the path to the filetype,
# open it with a default program.
# Example: './test.pdf' would be 'zathura test.pdf'
alias -s {conf,md,txt}=$EDITOR
alias -s {avi,mpeg,mpg,mp4,m4v,mov,m2v,mkv}=mpv
alias -s pdf=zathura

# cd into directories
setopt AUTO_CD
# ------------------------------------------------------------------}}}

# X title  ---------------------------------------------------------{{{
# Set the title of the current terminal to the last entered command
case $TERM in rxvt*|*term|linux|*term-256color)
	if [[ ! -z $SSH_TTY ]]; then
		preexec () { print -Pn "\e]0;%n@%m %~ [$1]\a" };
	else
		preexec () { print -Pn "\e]0;%n %~ [$1]\a" };
	fi
esac;
# ------------------------------------------------------------------}}}

# Aliases ----------------------------------------------------------{{{
# Load files if they exist
[[ -f ~/.aliases ]] && source ~/.aliases
# Second one for host specific aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local
# ------------------------------------------------------------------}}}

# Environment variables  -------------------------------------------{{{
# Print time how long a program run, if the time exceeds 30s
export REPORTTIME=30
# Default EDITOR preferences based on availability: neovim, vim, nano
if which nvim > /dev/null 2>&1; then
    export EDITOR="nvim"
elif which vim > /dev/null 2>&1; then
    export EDITOR="vim"
else
    export EDITOR="nano"
fi
# Use vim/nvim as manpager
if [ "$EDITOR" == "nvim" ] || [ "$EDITOR" == "vim" ]; then
    export MANPAGER="/bin/sh -c \"col -b | \
        $EDITOR -c'set ft=man ts=8 nomod nolist nonu noma' \
        -c 'nmap q :q!<CR>' -c'nmap <Up> <C-Y>' \
        -c'nmap <Down> <C-E>' -c'set nonumber' \
        -c'set norelativenumber' -\""
fi
# ------------------------------------------------------------------}}}
