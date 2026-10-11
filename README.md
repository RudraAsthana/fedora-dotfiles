# Fedora Workspace & Dotfiles

A highly modular, performance-optimized configuration environment for Fedora Linux. This setup transitions heavy GUI IDE workflows into a lightweight, terminal-native ecosystem tailored for seamless C++/Python development and rapid LaTeX typesetting for academic and legal study manuals.

## System Architecture

### The Terminal Stack
* **Emulator:** [Ghostty](https://ghostty.org/) – GPU-accelerated, true-color terminal.
* **Shell:** Zsh.
* **Fuzzy Finder:** `fzf` – Integrated into Zsh for `Ctrl+R` (command history) and `Ctrl+T` (file insertion).

### The Editor: Neovim (v0.12+)
Configured via `lazy.nvim` with a strict modular directory structure to maintain zero-clutter root files and instant startup times.

    ~/.config/nvim/
    ├── init.lua                 # The Engine: Bootstraps Lazy and loads modules
    ├── lua/
    │   ├── core/
    │   │   └── options.lua      # Base mechanics (Line numbers, tabs, legacy provider disables)
    │   └── plugins/
    │       ├── core_plugins.lua # Theme (One Dark Pro), LSP (Mason), Treesitter, Telescope
    │       ├── editor.lua       # Quality of Life tools (nvim-autopairs)
    │       └── latex.lua        # Vimtex compiler definitions & viewer sync
    └── snippets/
        ├── package.json         # Bridge mapping to force LaTeX associations
        └── tex.json             # Pure JSON snippet library (VS Code format)

## LaTeX Workflow & Typography

This environment is heavily optimized for continuous LaTeX compilation, specifically tailored for TeX Gyre Bonum typography and Unicode math.

* **Compiler:** `latexmk` utilizing the `XeLaTeX` engine.
* **Live Viewer:** Papers (Fedora GTK4 viewer) with forward-search synchronization.
* **Engine:** `Vimtex`. Compilation runs asynchronously in the background.

### Custom Snippet Library
LuaSnip is bridged to `nvim-cmp` to provide instant boilerplate generation:
* `bonumdoc`: Universal LaTeX template forcing TeX Gyre Bonum across text and math modes.
* `portfolio`: Formatted structure for leadership and Model United Nations portfolios.
* `latex-notes-boilerplate`: Clean, elegant title page generation for physics and engineering notes.
* `default`: Tab-navigable boilerplate for analytical essays and constitutional law notes with automated TOC spacing.
* `note`: Two-sided, wide-margin (`sidenotes`) layout for entrance examination study manuals.

## Installation & Bootstrap

This repository is managed as a **Bare Git Repository**. This prevents home-directory clutter, requires no symlinking scripts, and allows configurations to remain in their native `.config` paths.

### 1. Prerequisites
Install the required system dependencies on a fresh Fedora installation:

    sudo dnf install neovim git gh fzf zsh texlive-latexmk texlive-xetex evince

### 2. Clone the Bare Repository
Clone the configuration database into a hidden folder:

    git clone --bare https://github.com/RudraAsthana/fedora-dotfiles.git $HOME/.dotfiles

### 3. Initialize the Environment
Define the local alias and checkout the files to your home directory:

    alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
    dotfiles checkout

*(If the checkout fails due to pre-existing default files like `.zshrc`, delete or back up the conflicting files and run `dotfiles checkout` again.)*

### 4. Optimize Git Tracking
Hide untracked files so running `dotfiles status` doesn't list your personal downloads and documents:

    dotfiles config --local status.showUntrackedFiles no

## Essential Keybindings

| Context | Command | Action |
| :--- | :--- | :--- |
| **Zsh** | `Ctrl + R` | Fuzzy search command history |
| **Zsh** | `Ctrl + T` | Fuzzy search file paths to insert into prompt |
| **Zsh** | `Alt + C` | Fuzzy search directory to `cd` into |
| **Neovim** | `<Space> + f + f` | Telescope: Find files |
| **Neovim** | `<Space> + f + g` | Telescope: Live grep (search text inside files) |
| **Vimtex** | `\ll` | Start background compilation |
| **Vimtex** | `\lv` | Open PDF viewer (Papers) to cursor location |
| **Vimtex** | `cse` | Change Surrounding Environment (e.g., `itemize` to `enumerate`) |
| **Vimtex** | `Alt + Enter` | Smart newline (auto-inserts `\item`) |

## License
This project is licensed under the [GNU General Public License v3.0 (GPLv3)](LICENSE). You are free to copy, modify, and distribute this configuration, provided that any modified versions are also open-source under the same license.
