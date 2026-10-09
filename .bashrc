# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# TeX Live 2026
export PATH=/usr/local/texlive/2026/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2026/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2026/texmf-dist/doc/info:$INFOPATH
. "$HOME/.cargo/env"
alias ls="eza --long --all --group --group-directories-first --icons --header --time-style long-iso --git"

# ─── Modern tool aliases ───
alias cat='bat'
alias grep='rg'
alias find='fdfind'
alias du='dust'
alias ls='eza --long --all --group --group-directories-first --icons --header --time-style long-iso --git'

# ─── Navigation ───
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias back='cd -'

# ─── Safety nets ───
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# ─── Quick look ───
alias h='history | grep '
alias dfh='df -h'
alias duh='du -sh ./* ./.* 2>/dev/null'

# ─── Git shortcuts ───
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git log --oneline --graph --decorate -15'

# ─── Misc ───
alias c='clear'
alias l1='ls -1'
alias serve='python3 -m http.server'

# ─── zoxide ───
eval "$(zoxide init bash)"

# ─── fzf ───
source <(fzf --bash)
