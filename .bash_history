sudo dnf upgrade
clear
sudo dnf install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser
clear
fwupdmgr refresh
fwupdmgr update
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
clear
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo dnf install qbittorrent
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc && echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update && sudo dnf install code # or code-insiders
clear
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install vlc   
sudo tlmgr update --all
mkdir temp
cd temp
curl -L -o install-tl-unx.tar.gz https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
zcat < install-tl-unx.tar.gz | tar xf - # note final - on that command line
cd install-tl-2*
sudo perl ./install-tl --no-interaction # as root or with writable destination;
printf '\n# TeX Live 2026\nexport PATH=/usr/local/texlive/2026/bin/x86_64-linux:$PATH\nexport MANPATH=/usr/local/texlive/2026/texmf-dist/doc/man:$MANPATH\nexport INFOPATH=/usr/local/texlive/2026/texmf-dist/doc/info:$INFOPATH\n' >> ~/.bashrc && source ~/.bashrc
tex --version
fmtutil-sys --all
sudo dnf install "perl(File::Find)"
fmtutil-sys --all
sudo /usr/local/texlive/2026/bin/x86_64-linux/fmtutil-sys --all
sudo tlmgr update --all
sudo dnf install kde-connect   
cd ..
rm -rf temp
texlive --version
tex --version
clear
sudo dnf upgrade
clear
sudo dnf install gnome-shell-extension-pop-shell xprop
gnome-extensions enable pop-shell@system76.com
sudo dnf install gnome-extensions-app
code .
sudo dnf install rclone
cd ..
clear
rclone config
rclone ls gdrive:.
rclone ls gdrive
rclone ls gdrive:
htop
sudo dnf install htop
clear
curl -fsSL https://raw.githubusercontent.com/Evren-os/rustor/main/install.sh | bash
curl https://sh.rustup.rs -sSf | sh
sudo dnf groupinstall "Development Tools"
sudo dnf group install "Development Tools"
sudo dnf install @development-tools
sudo dnf clean all
sudo dnf makecache
sudo dnf group install "Development Tools" --disablerepo=rpmfusion-free-updates
clear
sudo dnf install neofetch
sudo dnf install fastfetch
fastfetch
cd Documents/
cd Proposal/
code .
sudo dnf upgrade
sudo dnf update
sudo dnf upgrade
clear
fastfetch
flatpak install flathub net.ankiweb.Anki
gnome-terminal
ptyxis
which ptyxis
sudo dnf upgrade
clear
sudo dnf upgrade
clear
sudo dnf install neovim
clear
neovim
nvim
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip   
fc-cache -fv   
clear
cd ..
ls
sudo dnf install eza   
clear
eza
clear
echo 'alias ls="eza --long --all --group --group-directories-first --icons --header --time-style long-iso --git"' >> ~/.bashrc   
source ~/.bashrc   
clear
ls
clear
ls
clear
sudo dnf install -y bat ripgrep fd-find fzf btop du-dust zoxide   
curl -sSL https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz | tar xz
sudo install eza /usr/local/bin/eza   
clear
cat >> ~/.bashrc << 'EOF'

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

# ─── zoxide (smart cd) ───
eval "$(zoxide init bash)"

# ─── fzf ───
source <(fzf --bash)
EOF   



clear
cat .bashrc
cat >> ~/.bashrc << 'EOF'
clear
cat >> ~/.bashrc << 'EOF'
clear
cat .bashrc
clear
source ~/.bashrc   
sed -i '/^EOF$/d' ~/.bashrc
clear
source ~/.bashrc   
sed -i '/^EOF$/d' ~/.bashrc
clear
cat .bashrc
nvim .
clear
source ~/.bashrc   
clear
sudo dnf install zsh starship zsh-autosuggestions zsh-syntax-highlighting
curl -sS https://starship.rs/install.sh | sh
clear
sudo dnf install zsh zsh-autosuggestions zsh-syntax-highlighting
clear
zsh
clear
rm ~/.zshrc ~/.config/starship.toml
code .zshrc
ls
rm -rf .zshrc
ls
rm -rf ~/.config/starship.toml
clear
code .zshrc
zsh
chsh -s $(command -v zsh)
echo $SHELL
