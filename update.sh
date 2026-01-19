#!/bin/bash

cd ~/dev/personal/my_dotfiles

cp -rf ~/.config/kitty/ .
cp -rf ~/.config/nvim/ .
cp -rf ~/.config/fish/ .
cp -f ~/.config/starship.toml .
cp -f ~/.local/bin/kitty-sessionizer scripts/

git add .

if ! git diff-index --quiet HEAD; then
    git commit -m "autocommit: $(date)"
    git push origin main
    echo "Backup enviado com sucesso!"
else
    echo "Sem alterações para guardar."
fi
