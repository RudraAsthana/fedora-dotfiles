# Zsh Configuration

# Enable unique paths (Zsh native way to prevent duplicate PATH entries)
typeset -U PATH path
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# History settings (Required for zsh-autosuggestions to remember past commands)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Rust / Cargo
. "$HOME/.cargo/env"

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
eval "$(zoxide init zsh)"

# ─── fzf ───
source <(fzf --zsh)

# Initialize completion for installed binaries
autoload -Uz compinit
compinit

# Source the autosuggestions plugin
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Source syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Initialize Starship prompt
eval "$(starship init zsh)"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

setopt interactivecomments

# Fetch Command
macchina

# DotFile Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
export PATH="$(ruby -e "print Gem.user_dir")/bin:$PATH"

# System Update Aliase
alias sysu='sudo dnf upgrade --refresh'
