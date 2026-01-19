#!/bin/bash

cd ~/dev/personal/my_dotfiles

cp -rf ~/.config/kitty kitty/.config/
cp -rf ~/.config/nvim nvim/.config/
cp -f ~/.config/starship.toml startship/.config/
cp -f ~/.local/bin/kitty-sessionizer scripts/.local/bin/

git add .
if ! git diff-index --quiet HEAD; then
    git commit -m "autocommit: $(date)"
    git push origin main
    echo "✅ Backup enviado com sucesso!"
else
    echo "💤 Sem alterações para guardar."
fi
