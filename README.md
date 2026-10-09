# Fedora Dotfiles

A modular, high-performance configuration environment for Fedora Linux.

## Environment Stack
* **Editor**: Neovim (v0.12+) with a modular Lua architecture.
* **LaTeX Workflow**: Automated background compilation via Vimtex, XeLaTeX, and Papers (GTK4), integrated with custom LuaSnip JSON snippets.
* **Terminal**: Ghostty.
* **Shell**: Zsh augmented with `fzf` for fuzzy finding and directory navigation.

## Installation

This repository is managed as a bare Git repository to avoid symlink clutter in the home directory. To install these configurations on a new machine, run the following commands:

```bash
# 1. Clone the repository as a bare git database
git clone --bare [https://github.com/RudraAsthana/fedora-dotfiles.git](https://github.com/RudraAsthana/fedora-dotfiles.git) $HOME/.dotfiles

# 2. Define the temporary alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# 3. Checkout the configuration files
# (Note: If this fails, back up or delete conflicting default files like .zshrc first)
dotfiles checkout

# 4. Hide untracked files to keep Git status clean
dotfiles config --local status.showUntrackedFiles no
