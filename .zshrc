#!/bin/sh

# ZSH Options
setopt appendhistory
setopt nomatch menucomplete
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')
unsetopt BEEP # stops any beeping in terminal

# Functions
function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$HOME/.zplugins/$PLUGIN_NAME" ]; then
        source "$HOME/.zplugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" ||
        source "$HOME/.zplugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        if git clone "https://github.com/$1.git" "$HOME/.zplugins/$PLUGIN_NAME"; then
            echo "✅ $PLUGIN_NAME plugin installed"
        else
            echo "❌ Failed to install $PLUGIN_NAME plugin"
        fi
    fi
}

# Exports
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"

# Keybings
bindkey '^I'   complete-word 
bindkey '^[[Z' autosuggest-accept

# Prompt
autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!'
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}"$'\ue0a0'"%{$fg[magenta]%} %b%{$fg[blue]%})"

# format our main prompt for hostname current folder, and permissions.
PROMPT="%B%{$fg[magenta]%}[%{$fg[green]%}sid%{$fg[yellow]%}@%{$fg[green]%}dawn%{$fg[magenta]%}] %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}"

PROMPT+="\$vcs_info_msg_0_ "

# Welcome Message
# eval "neofetch --color_blocks off"