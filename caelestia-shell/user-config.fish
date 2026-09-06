fnm env --use-on-cd --shell fish | source

abbr edit 'nvim'

fish_add_path $HOME/.opencode/bin
fish_add_path $HOME/.local/bin

function dev
    kitten @ launch --type=tab --cwd ~/dev --tab-title "dev"
end

function configs
    kitten @ launch --type=tab --cwd ~/.config --tab-title "configs"
end

function study
    kitten @ launch --type=tab --cwd ~/studys --tab-title "study"
end

function uni
    kitten @ launch --type=tab --cwd ~/studys/university --tab-title "university"
end

function fish_greeting
    command -v fastfetch &> /dev/null && fastfetch --config nyarch
end

