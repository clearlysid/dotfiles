#!/bin/sh

# 1. Setup development environment
# 2. Tweak macOS preferences
# 3. Install apps

# Function to install packages
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

# Function to install macOS apps with brew cask
install_apps() {
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
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/siddharth/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  echo '✅ Homebrew installed'
  echo "--------------------\n"
fi

# Install Git if not installed
if ! [ -x "$(command -v git)" ]; then
  echo "❌ git is not installed. Installing Git..."  
  install_packages git # Install Git
else
  echo "✅ git is already installed"
fi

# Install Zsh if not installed
if ! [ -x "$(command -v zsh)" ]; then
  echo "❌ zsh is not installed. Installing Zsh..."
  install_packages zsh # Install Zsh
else
  echo "✅ zsh is already installed"
fi

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

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
# 2. Tweak macOS Preferences
####################################

if [ "$(uname)" == "Darwin" ]; then
  # Remove login message in Apple Terminal
  touch ~/.hushlogin

  # Tweak macOS preferences
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
  echo "✅ Disabled automatic spelling correction"

  defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
  echo "✅ Disabled automatic capitalization"

  defaults write com.apple.menuextra.battery ShowPercent -bool true
  echo "✅ Battery percentage display enabled"

  defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
  echo "✅ 3-finger drag gesture enabled"
fi


####################################
# 3. Install apps  
####################################

# run the following only on macos
if [ "$(uname)" == "Darwin" ]; then
  # Install apps
  install_apps \
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
    obsidian
fi