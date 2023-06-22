#!/bin/sh

# 1. Setup development environment
# 2. Tweak macOS preferences
# 3. Install apps

# Function to install brew packages
install_packages() {
  for pkg in "$@"; do
    brew install "$pkg"
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

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Create .zprofile and add Homebrew to it
touch ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/siddharth/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo '✅ brew installed'
echo "--------------------\n"

# Install useful packages
install_packages python neofetch sl

# Install NVM (Not supported via Homebrew)
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh" | zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "✅ nvm installed"

# Install Node and NPM (latest and LTS)
nvm install node
nvm install --lts

# Install Global NPM packages
npm install yarn netlify-cli -g

# Move .zshrc to ~
mv ./.zshrc ~

# Configure Git


####################################
# 2. Tweak macOS Preferences
####################################

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


####################################
# 3. Install apps  
####################################

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
  slack \
  microsoft-edge \
  loom \
  obsidian