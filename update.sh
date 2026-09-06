#!/bin/bash

cd ~/dev/personal/caelestia-nvim-dotfiles/

cp -rf ~/.config/kitty/ .
cp -rf ~/.config/nvim/ .
cp -rf ~/.config/fish caelestia/
cp -rf ~/.config/zed/* zed/
cp -f ~/.local/bin/kitty-sessionizer scripts/

cp -rf ~/.config/caelestia/* caelestia/

rm -rf kitty/kitty-utils

git add .

if ! git diff-index --quiet HEAD; then
    git commit -m "autocommit: $(date)"
    git push origin main
    echo "Backup enviado com sucesso!"
else
    echo "Sem alterações para guardar."
fi
