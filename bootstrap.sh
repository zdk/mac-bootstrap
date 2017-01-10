#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail


# helpers
function echo_ok     { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn   { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error  { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

# Install XCode Command Line Tools

if type xcode-select >&- && xpath=$( xcode-select --print-path ) &&
     test -d "${xpath}" && test -x "${xpath}" ; then
  echo_ok "Command Line Tools is already installed"
else
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -i "$PROD" --verbose;
fi

# Set permissions
cd ~
mkdir -p tmp
echo_warn "setting permissions..."
for dir in "/usr/local /usr/local/bin /usr/local/include /usr/local/lib /usr/local/share"; do
    sudo chgrp admin $dir
    sudo chmod g+w $dir
done

# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# homebrew
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

if hash brew &> /dev/null; then
    echo_ok "Homebrew already installed"
else
    echo_warn "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install brew-cask
brew install caskroom/cask/brew-cask
brew update

# install chefDK
brew cask install chefdk

# run Chef cookbooks
cd cookbooks

chef-client -z -o mac_bootstrap
