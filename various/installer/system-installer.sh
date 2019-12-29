#!/usr/bash




### --------------- BASE DIRECTORIES ---------------
mkdir $HOME/Documents 
mkdir $HOME/Packs
mkdir $HOME/Pictures
mkdir $HOME/Downloads

### --------------- DOT FILES --------------- 
echo "Setting up dotfiles..."

cd $HOME

echo ".dots" >> .gitignore

git clone --bare https://github.com/ginkobab/dots $HOME/.dots

git --git-dir=$HOME/.dots --work-tree=$HOME stash
git --git-dir=$HOME/.dots --work-tree=$HOME checkout
git --git-dir=$HOME/.dots --work-tree=$HOME config --local status.showUntrackedFiles no

cd $HOME/Documents 
git clone https://github.com/ginkobab/scripts

cd $HOME/Documents 
git clone https://github.com/ginkobab/Projects


### --------------- FONT ---------------
cd $HOME/Packs 

git clone https://aur.archlinux.org/nerd-fonts-complete.git 
cd nerd-fonts-complete 
makepkg -si



### --------------- VIRTUALENV --------------- 
echo "Setting up virtualenv..."
python3 -m venv $HOME/.virtualenvs/env

source $HOME/.virtualenvs/env/bin/activate
pip install --upgrade pip
pip install -r $HOME/.backup/requirements.txt




### --------------- VIM-PLUG ---------------
echo "Setting up vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


### --------------- SUCKLESS ---------------
cd $HOME/Packs 
git clone https://aur.archlinux.org/dwm-git
cd $HOME/Packs/dwm-git
makepkg -si

cd $HOME/Packs 
git clone https://aur.archlinux.org/st-git
cd $HOME/Packs/st-git 
makepkg -si

cd $HOME/Packs 
git clone https://aur.archlinux.org/slstatus-git
cd $HOME/Packs/slstatus-git 
makepkg -si

cd $HOME/Packs 
git clone https://aur.archlinux.org/dmenu-git
cd $HOME/Packs/dmenu-git
makepkg -si



echo "Remember to run PlugInstall in Neovim\n"
echo "Remember to patch suckless stuff"
