#!/bin/bash

# Check if we can read the dictionary replacement
if defaults read -g NSUserDictionaryReplacementItems >/dev/null 2>&1; then
	# Set up some autocorrects
	defaults write -g NSUserDictionaryReplacementItems -array-add '{on=1;replace=the;with="teh";}'
fi

add_alias() {
	add_to_rc 'alias '$1'="'$2';'$1'"'
}

# Add things to the end of an RC file
add_to_rc() {
	if [ -f "$HOME/.bashrc" ]; then
		echo $* >> "$HOME/.bashrc"
	fi
	if [ -f "$HOME/.zshrc" ]; then
		echo $* >> "$HOME/.zshrc"
	fi
}

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
		add_alias cd "figlet CHANGING DIRECTORY"
		add_alias ls "figlet LISTING FILES"
		add_alias rm "figlet REMOVING FILES"
	fi
	if command -v cowsay >/dev/null 2>&1; then
		add_to_rc 'cowsay Welcome $USER'
	fi
fi

