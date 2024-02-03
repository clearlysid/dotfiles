#!/bin/sh

# 1. Setup development environment
# 2. Install apps
# 3. Tweak system preferences

install_packages() {
  for pkg in "$@"; do
    if [ "$(uname)" == "Darwin" ]; then
      brew install "$pkg" # macOS
    else
      sudo apt install "$pkg" # Linux
    fi
    if [ $? -eq 0 ]; then
      echo "✅ $pkg installed"
      echo "--------------------"
    else
      echo "❌ Failed to install $pkg"
      echo "--------------------"
    fi
  done
}

install_mac_apps() {
  for app in "$@"; do
    brew install --cask "$app"
    if [ $? -eq 0 ]; then
      echo "✅ $app installed"
      echo "--------------------"
    else
      echo "❌ Failed to install $app"
      echo "--------------------"
    fi
  done
}

####################################
# 1. Setup development environment 
####################################

# Install Homebrew (macOS only)
if [ "$(uname)" == "Darwin" ]; then
  if ! [ -x "$(command -v brew)" ]; then
    echo "❌ Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Create .zprofile and add Homebrew to it
    touch ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  echo '✅ Homebrew installed'
  echo "--------------------\n"
fi

# Install Git if not installed
if ! [ -x "$(command -v git)" ]; then
  echo "❌ Installing Git..."  
  install_packages git # Install Git
else
  echo "✅ Git installed"
fi

# Install Zsh if not installed
if ! [ -x "$(command -v zsh)" ]; then
  echo "Installing Zsh..."
  install_packages zsh # Install Zsh
else
  echo "✅ Zsh installed"
fi

# install rust if not installed
if ! [ -x "$(command -v rustc)" ]; then
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
else
  echo "✅ Rust installed"
fi

# Install other packages
install_packages neofetch sl

# Install FNM (Fast Node Manager)
curl -fsSL https://fnm.vercel.app/install | zsh
echo "✅ fnm installed"

eval "$(fnm env --use-on-cd)"
fnm completions --shell zsh

# Install Node LTS
fnm install --lts
echo "✅ Node LTS installed"

# Install Yarn
npm install yarn -g

# Move .zshrc to ~
mv ./.zshrc ~


####################################
# 2. Install apps  
####################################

# macOS apps
if [ "$(uname)" == "Darwin" ]; then
  install_mac_apps \
    visual-studio-code \
    raycast \
    handbrake \
    iina \
    the-unarchiver \
    mouse-fix \
    monitorcontrol \
    spitfire-audio \
    ableton-live-standard \
    figma \
    framer \
    blender \
    affinity-designer \
    affinity-photo \
    obsidian \
    google-chrome
fi

#  check if os is linux
if [ "$(uname)" == "Linux" ]; then
  sudo apt update

  # google chrome
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb
  rm google-chrome-stable_current_amd64.deb

  # vs code
  sudo apt install software-properties-common apt-transport-https
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install code
fi


####################################
# 3. Tweak macOS Preferences
####################################

if [ "$(uname)" == "Darwin" ]; then
  
  touch ~/.hushlogin # Remove login message

  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  echo "✅ Disabled automatic spelling correction"

  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
  echo "✅ Disabled automatic capitalization"

  defaults write com.apple.menuextra.battery ShowPercent -bool true
  echo "✅ Battery percentage display enabled"

  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  echo "✅ 3-finger drag gesture enabled"
fi