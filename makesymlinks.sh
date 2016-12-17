#!/bin/bash

# This script creates symlinks from home directory to desired dotfiles in ~/dotfiles

# variables
curr_dir=~/dotfiles
old_dir=~/dotfiles_old
files="vimrc"

# create folder for backup of old dotfiles
mkdir -p $old_dir

cd $curr_dir

for file in $files; do
  echo "Moving old dotfiles to backup folder..."
  mv ~/.$file $old_dir
  echo "Now creating symlinks for current dotfiles..."
  ln -fs $curr_dir/$file ~/.$file
done

