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
  obsidian