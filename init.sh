#!/bin/sh
restart_shell() {
  exec zsh
}

echo "running setup ..."
echo "creating dev dirs ..."
mkdir ~/Developer
mkdir ~/Developer/repos
mkdir ~/Developer/playground

echo "setting up homebrew ..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
restart_shell

echo "setting up node ..."
brew install nvm
nvm install --lts
node --version

echo "setting up shell ..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
npm install --global pure-prompt
echo 'autoload -U promptinit; promptinit \n prompt pure' >> .zshrc
brew install zsh-syntax-highlighting
echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrcrestart_shell

echo "setting up python ..."
brew install pipx
brew install python
alias python=python3
pipx install poetry

echo "setting up sqlite ..."
brew install sqlite

echo "setting up geist font ..."
curl -LOJ https://github.com/vercel/geist-font/releases/download/1.1.0/Geist.Mono.zip
unzip Geist.Mono.zip
cp Geist.Mono/*.otf /Library/Fonts/

echo "setting up vscode ..."
brew install --cask visual-studio-code
restart_shell
echo 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' >> .zshrc
cp setup/configs/vs-settings.json ~/Library/Application Support/Code/User/settings.json
restart_shell
code --install-extension drcika.apc-extension
code --install-extension daltonMenezes.aura-theme
code --install-extension eamodio.gitlens
code --install-extension equinusocio.moxer-icons
code --install-extension esbenp.prettier-vscode

echo "setting up iterm ..."
brew install --cask iterm2