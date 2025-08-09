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
mkdir $HOME/.config

# Add ~/Applications/bin to PATH if not already present
if ! echo $PATH | grep -q "$HOME/Applications/bin"; then
  echo 'export PATH="$HOME/Applications/bin:$PATH"' >> $HOME/.zprofile
  export PATH="$HOME/Applications/bin:$PATH"
fi


# Create unraid mounts
mkdir $HOME/homedir-pbear
mkdir $HOME/downloads_unraid
mkdir $HOME/media


# Symlink the Mackup config file to the home directory
ln -sf .dotfiles/.mackup.cfg $HOME/.mackup.cfg

# Symlink the .config config files folder to the home directory
ln -sf $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/Backups/Mackup/.config $HOME/.config


# Set macOS preferences - we will run this last because this will reload the shell
source ./.macos
