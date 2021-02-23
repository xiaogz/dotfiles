#!/bin/bash

# MSYS2 specfic tools that aren't installed by default
if [[ -n "${MSYSTEM}" ]]; then
    pacman -S man curl wget tree tmux vim parallel unzip
fi

#TODO: install truetype font from commandline
#if [[ ! -f "Go-Mono.ttf" ]]; then
#    wget https://github.com/golang/image/raw/master/font/gofont/ttfs/Go-Mono.ttf
#fi

# Installs VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# This script creates symlinks from home directory to desired dotfiles in ~/dotfiles

# variables
curr_dir=~/dotfiles
old_dir=~/dotfiles_old
files="vimrc tmux.conf clang-format globalgitignore"

if [[ -n "${MSYSTEM}" ]]; then
    files+=" minttyrc"
fi

# create folder for backup of old dotfiles
mkdir -p $old_dir

cd $curr_dir

for file in $files; do
  echo acting on $file
  if [[ -f "~/.$file" ]]; then
      mv ~/.$file $old_dir
  fi
  touch $file
  ln -fs $curr_dir/$file ~/.$file
done

# setup Vim plugins and exit
vim +PlugInstall +qall

# copy the ycm config file to its proper place
if [ -d ~/.vim/plugged/YouCompleteMe ]; then
    cp ycm_extra_conf.py ~/.vim/plugged/YouCompleteMe
fi

# add extra aliases to ~/.bashrc
# TODO: use a separate file for bash aliases
echo "# extra git-related aliases" >> ~/.bashrc
echo "alias gs='git status'" >> ~/.bashrc
echo "alias gsb='git status -sb'" >> ~/.bashrc
echo "alias gl='git log'" >> ~/.bashrc
echo "alias gd='git diff'" >> ~/.bashrc
echo "alias glo='git log --pretty=format:"%h  %as  %f"'" >> ~/.bashrc
echo "alias gl1='git log -n 1'" >> ~/.bashrc

if [[ -n "${MSYSTEM}" ]]; then
    echo "alias rg='rg --path-separator=\"//\"'" >> ~/.bashrc
fi

echo "#append slash to symlinked directories during autocomplete tabbing" >> ~/.bashrc
echo "bind 'set mark-symlinked-directories on'" >> ~/.bashrc

# add extra settings to ~/.profile
echo "# prevent ctrl+D from closing terminal" >> ~/.profile
echo "set -o ignoreeof" >> ~/.profile
echo "# change capslock to control" >> ~/.profile
echo "setxkbmap -layout us -option ctrl:nocaps" >> ~/.profile

# add useful git alias (stops push --force if someone else has updated upstream branch)
git config --global alias.pushfwl 'push --force-with-lease'
git config --global core.excludesfile '~/.globalgitignore'

