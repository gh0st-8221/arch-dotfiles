HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
PROMPT='%~ > '
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -e
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
alias hx=helix
alias g733-off="headsetcontrol -l 0"
alias g733-on="headsetcontrol -l 1"
alias g733-bat="headsetcontrol -b"
alias mywatch="tty-clock -C 3 -c -s"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}
export EDITOR="helix"
export VISUAL="helix"
export LFS=/mnt/lfs
export PATH="$HOME/.cargo/bin:$PATH"
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export XDG_CURRENT_DESKTOP=generic
