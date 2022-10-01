
# install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


# add homebrew to .zprofile 
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/siddharth/.zprofile

eval "$(/opt/homebrew/bin/brew shellenv)"

# remove the default message in apple terminal
touch ~/.hushlogin

# install python, neofetch, sl and ffmpeg
brew install python neofetch sl ffmpeg

# install nvm (doing this from homebrew is not supported)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | zsh


# Append the following lines to .zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# install node (latest and latest LTS) with nvm
nvm install node
nvm install --lts

# with npm, install yarn and netlify-cli
npm install yarn -g
npm install netlify-cli -g

# install macOS apps
brew install --cask visual-studio-code
brew install --cask raycast
brew install --cask handbrake
brew install --cask iina
brew install --cask the-unarchiver
brew install --cask mouse-fix
brew install --cask monitorcontrol
brew install --cask kap