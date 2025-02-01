# If not running interactively, don't do anything
[[ $- != *i* ]] && return

autoload -U colors && colors

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

PS1='%F{blue}%~ %(?.%F{green}.%F{red})%#%f '
alias grep='grep --color=auto' 
alias ls='ls --color=auto'  # Adds color to ls
alias la='ls -a --color=auto'  # Shows all files except "." and ".."
alias ll='ls -l --color=auto'  # Long listing with file details
alias lla='ls -la --color=auto'  # Long listing, including hidden files
alias find='find . -type f'  # Find files in the current directory 
#alias br= echo 5000 > /sys/class/backlight/intel_backlight/brightness
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

# vi mode
bindkey -v
#export KEYTIMEOUT=1

bindkey "^R" history-incremental-pattern-search-backward
bindkey -M viins 'kj' vi-cmd-mode
setopt autocd   
setopt interactive_comments
setopt inc_append_history
unsetopt beep
export KEYTIMEOUT=20

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';; # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}

zle -N zle-l ne-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt. 


# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/simsim/.zshrc'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# cd + ls?
cd() {
  builtin cd "$@" && ls
}

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '^B' autosuggest-toggle

# End of lines added by compinstall
