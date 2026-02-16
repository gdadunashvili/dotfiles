eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(starship init zsh)"
# cursor shape
# Set cursor to block in normal mode
function zle-keymap-select zle-line-init zle-line-finish {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[2 q'
  else
    echo -ne '\e[5 q'
  fi
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select


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

function vi-yank-xclip {
    zle vi-yank
    echo "$CUTBUFFER" | xclip -i -selection clipboard
}

zle -N vi-yank-xclip
bindkey -M vicmd 'y' vi-yank-xclip
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


# Environment variables  -------------------------------------------{{{
# Print time how long a program run, if the time exceeds 30s
export REPORTTIME=30
# Default EDITOR preferences based on availability: neovim, nano
if which nvim > /dev/null 2>&1; then
    export EDITOR="nvim"
else
    export EDITOR="nano"
fi
# Use vim/nvim as manpager
if [ "$EDITOR" == "nvim" ]; then
    export MANPAGER='nvim +Man!'
fi
# ------------------------------------------------------------------}}}
plugin=(git bazel)
# zoxide
eval "$(zoxide init zsh)"

# Fuzzy finder  fzf  configureation
export FZF_DEFAULT_OPTS="--preview 'bat --style=full --color=always {}'"
export FZF_DEFAULT_COMMAND="fd --hidden -tf -td -tl"
source ~/dotfiles/fzf/key-bindings.zsh
source ~/dotfiles/fzf/completion.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
# Load files if they exist
[[ -f ~/.aliases ]] && source ~/.aliases


# keep destinations last
# Second one for host specific aliases
[[ -f ~/.destinations ]] && source ~/.destinations


###  RPP-BEGIN  ###
# Do not change content between BEGIN and END!
# This section is managed by a script.
if [[ -d "/usr/libexec/rpp_zshrc.d" ]]; then
    for rc_script in "/usr/libexec/rpp_zshrc.d/"*; do
      source "${rc_script}"
    done
fi
###  RPP-END  ###
