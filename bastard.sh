#!/bin/bash

# Check if we can read the dictionary replacement
if defaults read -g NSUserDictionaryReplacementItems >/dev/null 2>&1; then
	# Set up some autocorrects
	defaults write -g NSUserDictionaryReplacementItems -array-add '{on=1;replace=the;with="teh";}'
fi

# Test for various RC files to bomb
BASH=0
ZSH=0

if [ -f "$HOME/.bashrc" ]; then
	BASH=1
fi

if [ -f "$HOME/.zshrc" ]; then
	ZSH=1
fi

# Does homebrew exist?

if command -v brew >/dev/null 2>&1; then
	# It exists, install some toys and  if not already here
	if ! command -v sl >/dev/null 2>&1; then
		BREW_INSTALL+=" sl"
	fi
	if ! command -v cowsay >/dev/null 2>&1; then
		BREW_INSTALL+=" cowsay"
	fi
	if ! command -v figlet >/dev/null 2>&1; then
		BREW_INSTALL+=" figlet"
	fi
	
	if [ ! -z "$BREW_INSTALL" ]; then
		brew install $BREW_INSTALL >/dev/null 2>&1;
	fi

	# Alias these tools :-)
	if command -v figlet >/dev/null 2>&1; then
		echo 'alias cd="figlet CHANGING DIRECTORY; cd"'
	fi
fi

