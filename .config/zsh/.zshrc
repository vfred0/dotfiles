HISTFILE="${XDG_CONFIG_HOME}/zsh/history"
HISTSIZE=1000
SAVEHIST=1000
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
PATH="$PATH:$HOME/.dotnet/tools"
#WARP_THEMES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/warp-terminal/themes"
WARP_THEMES_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes"

##  mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

autoload -Uz colors && colors
autoload -Uz compinit && compinit
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search

setopt autocd nomatch interactive_comments
unsetopt beep notify

zmodload zsh/complist

zstyle ':completion:*' matcher-list "m:{a-zA-Z}={A-Za-z}"
zstyle ':completion:*' menu select

stty stop undef

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -v
bindkey -v '^?' backward-delete-char
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M vicmd 'j' down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

set_cursor_block() { echo -ne '\e[1 q'; }
set_cursor_beam() { echo -ne '\e[5 q'; }
preexec() { set_cursor_beam; }

zle-keymap-select() {
    case "${KEYMAP}" in
        vicmd) set_cursor_block ;;
        viins|main) set_cursor_beam ;;
    esac
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins
    set_cursor_beam
}
zle -N zle-line-init

set_cursor_beam

export PNPM_HOME="/home/vfred0/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
eval "$(starship init zsh)"

source "${XDG_CONFIG_HOME}/shell/aliasrc"
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"



# Load Angular CLI autocompletion.
source <(ng completion script)

export PATH=$PATH:/home/vfred0/.spicetify
