#!/usr/bin/env bash
# 
# (c) 2018, Montassar Ajam <montassar.ajam@gmail.com>
# This module is part of the automation setup project of new OSX machines
# done on the top of the following Gist:
#  
# https://gist.github.com/codeinthehole/26b37efa67041e1307db
#
# Bootstrap script for setting up a new OSX machine
# 
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716
# - https://news.ycombinator.com/item?id=8402079
# - http://notes.jerzygangi.com/the-best-pgp-tutorial-for-mac-os-x-ever/

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew tap homebrew/dupes
brew install coreutils
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-indent --with-default-names
brew install gnu-which --with-default-names
brew install gnu-grep --with-default-names

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed 
brew install findutils

# Install Bash 4
brew install bash

PACKAGES=( 
    # Code searching tool
    ag 
    ## Autotools setup ## 
    # Automate producing configure scripts for software packages
    autoconf
    # Automate producing Makefiles
    automake
    # lightweight Linux distribution made specifically to run Docker containers
    docker
    # Multimedia tool for transcoding, multimedia libraries providing and format support (...)
    ffmpeg
    # Tool to write multilingual programs.
    gettext
    # Tool for Creating, editing, and getting information about GIF images.
    gifsicle
    # Version Control System 
    git
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

echo "Cleaning up..."
brew cleanup
