#!/bin/sh

echo "Setting up your Mac..."

unraid=

# Check for Oh My Zsh and install if we don't have it
if test ! $(which omz); then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -sf .dotfiles/.zshrc $HOME/.zshrc

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file ./Brewfile

# Create Applications/bin and .config directories
mkdir -p $HOME/Applications/bin
mkdir $HOME.config

# Create unraid mounts
mkdir $HOME/homedir-pbear
mkdir $HOME/downloads_unraid
mkdir $HOME/media

read -p 'Unraid server IP: ' unraid

# mount some personnal shares:
sudo mount -t nfs -o vers=4 $unraid:/mnt/user/homedir-pbear /Users/pbear/homedir-pbear
sudo mount -t nfs -o vers=4 $unraid:/mnt/user/media /Users/pbear/media
sudo mount -t nfs -o vers=4 $unraid:/mnt/user/downloads /Users/pbear/downloads_unraid

# Symlink the Mackup config file to the home directory
ln -sf .dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
