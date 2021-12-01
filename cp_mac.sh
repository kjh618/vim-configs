#!/bin/sh

echo 'Neovim (no plugins)'
cp -v .config/nvim/init_no_plugins.lua ~/.config/nvim/init.lua
cp -v .config/nvim/lua/mappings.lua ~/.config/nvim/lua/

echo IdeaVim
cp -v .ideavimrc ~/
