#!/bin/sh
restart_shell() {
  exec zsh
}

exists() {
  command -v "$1" >/dev/null 2>&1
}

setup_dirs() {
  echo "creating dev dirs ..."
  dev_dir=~/Developer
  repos_dir=~/Developer/repos
  playground_dir=~/Developer/playground

  if [ -d $dev_dir ]
  then
    echo "$dev_dir already exists ..."
  else
    mkdir $dev_dir
  fi

  if [ -d  $repos_dir ]
  then
    echo "$repos_dir already exists ..."
  else
    mkdir $repos_dir
  fi

  if [ -d $playground_dir ]
  then
    echo "$playground_dir already exists ..."
  else
    mkdir $playground_dir
  fi
}

setup_brew() {
  if exists brew
  then
    echo "homebrew already exists ..."
  else
    echo "setting up homebrew ..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    restart_shell
  fi
}

setup_node() {
  if exists nvm
  then
    echo "nvm already exists"
  else
    echo "setting up nvm ..."
    brew install nvm
  fi

  if exists node
  then
    echo "node already exists"
  else
    echo "setting up node ..."
    nvm install --lts
  fi
}

setup_shell() {
  echo "setting up shell ..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  npm install --global pure-prompt
  echo 'autoload -U promptinit; promptinit \n prompt pure' >> .zshrc
  brew install zsh-syntax-highlighting
  echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
  restart_shell
}

setup_python() {
  echo "setting up python ..."

  if exists pipx
  then
    echo "pipx already exists ..."
  else
    brew install pipx
  fi

  if exists python
  then
    echo "python already exists ..."
  else
    brew install python
  fi

  if exists python
  then
    echo "overriding python cli with python3"
  fi

  echo "alias python=python3" >> ~/.zshrc

  if exists poetry
  then
    echo "poetry already exists ..."
  else
    pipx install poetry
  fi
}

setup_sqlite() {
  if exists sqlite3
  then
    echo "sqlite already exists ..."
  else
    echo "setting up sqlite ..."
    brew install sqlite
  fi
}

setup_font() {
  echo "setting up geist font ..."
  curl -LOJ https://github.com/vercel/geist-font/releases/download/1.1.0/Geist.Mono.zip
  unzip Geist.Mono.zip
  cp Geist.Mono/*.otf /Library/Fonts/
}

setup_vscode() {
  echo "setting up vscode ..."
  brew install --cask visual-studio-code
  restart_shell
  echo 'export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"' >> .zshrc
  cp setup/configs/vs-settings.json ~/Library/Application\ Support/Code/User/settings.json
  restart_shell
  code --install-extension drcika.apc-extension
  code --install-extension daltonMenezes.aura-theme
  code --install-extension eamodio.gitlens
  code --install-extension equinusocio.moxer-icons
  code --install-extension esbenp.prettier-vscode
}

setup_iterm() {
  echo "setting up iterm ..."
  brew install --cask iterm2
}

setup_orbstack() {
  echo "setting up orbstack (docker alternative) ..."
  brew install orbstack
}

echo "running setup ..."
setup_dirs
setup_brew
setup_node
setup_shell
setup_python
setup_sqlite
setup_font
setup_vscode
setup_iterm
setup_orbstack
