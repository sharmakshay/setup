#!/bin/sh
echo "running setup ..."
echo "creating dirs ..."
mkdir ~/Developer
mkdir ~/Developer/repos
mkdir ~/Developer/playground

echo "setting up homebrew ..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
exec zsh

echo "setting up node ..."
brew install nvm
nvm install --lts
node --version

echo "setting up shell ..."
npm install --global pure-prompt
echo 'autoload -U promptinit; promptinit \n prompt pure' >> .zshrc
brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrcexec zsh

echo "setting up python ..."
brew install pipx
brew install python
alias python=python3
pipx install poetry
