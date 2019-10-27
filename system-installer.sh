#!/usr/bin/fish

### You will need to have fish installed BEFORE executing this script



### --------------- MAIN PACKAGES ---------------
read -P "Do you want to download the folder scripts? y/n   " SCRI
if [ $SCRI = 'y' ]
    mkdir $HOME/Documents && cd Documents && git clone https://github.com/ginkobab/scripts
end

read -P "Do you want to download the folder Projects? y/n   " PROJ
if [ $PROJ = 'y' ]
    mkdir $HOME/Documents && cd Documents && git clone https://github.com/ginkobab/Projects
end

echo "Installing main packages...."
cd $HOME && wget https://raw.githubusercontent.com/ginkobab/dots/master/.pkglist
sudo pacman -S (cat .pkglist)


### --------------- FONT ---------------
read -P "Do you want to install the whole package of nerd fonts? (1.8GB) y/n   " NERD
if [ $NERD = 'y' ]
    echo "Installing nerd fonts..."
    mkdir $HOME/Packs && git clone https://aur.archlinux.org/nerd-fonts-complete.git && cd nerd-fonts-complete && makepkg -si
end


### --------------- VIRTUALENV --------------- 
echo "Setting up virtualenv..."
python3 -m venv ~/.virtualenvs/env
# put requirements here


### --------------- VIM-PLUG ---------------
echo "Setting up vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

### --------------- DOT FILES --------------- 
echo "Setting up dotfiles..."
cd $HOME && echo ".dots" >> .gitignore

git clone --bare https://github.com/ginkobab/dots $HOME/.dots

rm $HOME/.config/fish/fish_variables
git --git-dir=$HOME/.dots --work-tree=$HOME stash
git --git-dir=$HOME/.dots --work-tree=$HOME checkout
git --git-dir=$HOME/.dots --work-tree=$HOME config --local status.showUntrackedFiles no

### --------------- SUCKLESS ---------------
cd $HOME/Packs/dwm-git/src/dwm     && sudo make clean install
cd $HOME/Packs/dmenu-git/src/dmenu && sudo make clean install
cd $HOME/Packs/st-git/src/st       && sudo make clean install
cd $HOME/Packs/slstatus/src/sl     && sudo make clean install

### --------------- RANGER DEVICONS ---------------
cd $HOME/Packs
git clone https://aur.archlinux.org/ranger_devicons.git
cd ranger_devicons && makepkg -si
    
### --------------- DAEMONS ---------------
cd $HOME/Packs && git clone https://aur.archlinux.org/google-chrome.git && makepkg -si

### --------------- FONT SIZE ---------------
chmod a+x $HOME/Documents/scripts/fontsize.sh
source $HOME/Documents/scripts/fontsize.sh
echo Remember to run PlugInstall in Neovim

### --------------- FISH AS DEFAULT SHELL ---------------
echo "Setting Fish as default shell (needs to reboot)"
chsh -s /usr/bin/fish
read -P "Do you want to reboot now? y/n" REB
if [ $REB = 'y' ] 
    reboot
end

