#!/bin/bash

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# This script creates symlinks from home directory to desired dotfiles in ~/dotfiles

# variables
curr_dir=~/dotfiles
old_dir=~/dotfiles_old
files="vimrc tmux.conf"

# create folder for backup of old dotfiles
mkdir -p $old_dir

cd $curr_dir

for file in $files; do
  echo acting on $file
  touch $file
  mv ~/.$file $old_dir
  ln -fs $curr_dir/$file ~/.$file
done

# setup Vim plugins and exit
vim +PlugInstall +qall

# copy the ycm config file to its proper place
if [ -d ~/.vim/plugged/YouCompleteMe ]; then
    cp ycm_extra_conf.py ~/.vim/plugged/YouCompleteMe
fi

# add extra aliases to ~/.bashrc
echo "# extra git-related aliases" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc
echo "alias gsb='git status -sb'" >> ~/.bashrc
echo "alias gl='git log'" >> ~/.bashrc
echo "alias gd='git diff'" >> ~/.bashrc
echo "alias glo='git log --pretty=oneline'" >> ~/.bashrc

source ~/.bashrc

# add extra settings to ~/.profile
echo "# prevent ctrl+D from closing terminal" >> ~/.profile
echo "set -o ignoreeof" >> ~/.profile
echo "# change capslock to control" >> ~/.profile
echo "setxkbmap -layout us -option ctrl:nocaps" >> ~/.profile

source ~/.profile
