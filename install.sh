#!/bin/bash

if [ ! -f .dotfiles.env ]; then
    echo "A criar ficheiro de ambiente (.dotfiles.env)..."
    echo 'ACTIVE_ENVIRONMENT=""' > .dotfiles.env
    echo "REPO_DIR=\"$PWD\"" >> .dotfiles.env
    echo 'CONFIG_DIR="$HOME/.config"' >> .dotfiles.env
fi

source "$PWD/.dotfiles.env"

CORE_UTILITIES=("fastfetch" "kitty" "nvim" "scripts" "zed" "starship.toml")

# Não posso considerar o fish como core pois as shells tem configs visuais específicas do mesmo, pelo que a config logica e de prompt são instalados separadamente (lógica do shared)
ALL_UTILITIES=("${CORE_UTILITIES[@]}" "fish")

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        local timestamp=$(date +%s)
        mv "$dest" "${dest}.bak_${timestamp}"
        echo "Backup criado: ${dest}.bak_${timestamp}"
    fi

    # Cria o symlink
    ln -s "$src" "$dest"
    echo "✔ Linkado: $dest -> $src"
}

install_core_utilities() {
    echo -e "\n🔧 A instalar Core Utilities..."
    for item in "${CORE_UTILITIES[@]}"; do
        backup_and_link "$REPO_DIR/$item" "$CONFIG_DIR/$item"
    done
}

# FUNÇÕES DAS SHELLS
install_caelestia() {
    install_core_utilities
    echo -e "\n A instalar Caelestia Shell..."
    backup_and_link "$REPO_DIR/caelestia-shell" "$CONFIG_DIR/caelestia"

    mkdir -p "$CONFIG_DIR/fish/conf.d"
    backup_and_link "$REPO_DIR/shared/logic.fish" "$CONFIG_DIR/fish/conf.d/logic.fish"

    sed -i 's/^ACTIVE_ENVIRONMENT=.*/ACTIVE_ENVIRONMENT="caelestia"/' .dotfiles.env
    echo "✨ Caelestia Shell ativado!"
}

install_end4() {
    install_core_utilities
    echo -e "\n A instalar End4-pC..."
    backup_and_link "$REPO_DIR/end4-pC/illogical-impulse" "$CONFIG_DIR/illogical-impulse"

    mkdir -p "$CONFIG_DIR/hypr"
    backup_and_link "$REPO_DIR/end4-pC/hypr-custom" "$CONFIG_DIR/hypr/custom"

    mkdir -p "$CONFIG_DIR/fish/conf.d"
    backup_and_link "$REPO_DIR/shared/logic.fish" "$CONFIG_DIR/fish/conf.d/logic.fish"

    sed -i 's/^ACTIVE_ENVIRONMENT=.*/ACTIVE_ENVIRONMENT="end4"/' .dotfiles.env
    echo "✨ end4-pC ativado!"
}

install_interactive_utilities() {
    echo -e "\n📦 Utilities disponíveis:"
    local i=1
    for item in "${ALL_UTILITIES[@]}"; do
        echo "$i) $item"
        ((i++))
    done
    echo "0) Todas as Utilities acima"

    echo ""
    read -p "Introduz os números que queres atualizar (separados por espaço, ex: 1 3 7 ou 0 para todas): " choices

    choices=$(echo "$choices" | tr ',' ' ')

    local selected_utils=()
    if [[ "$choices" == *"0"* ]]; then
        selected_utils=("${ALL_UTILITIES[@]}")
    else
        for choice in $choices; do
            if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#ALL_UTILITIES[@]}" ]; then
                selected_utils+=("${ALL_UTILITIES[$((choice-1))]}")
            else
                echo "⚠️ Opção ignorada (inválida): $choice"
            fi
        done
    fi

    if [ ${#selected_utils[@]} -eq 0 ]; then
        echo "Nenhuma utility válida selecionada. Operação cancelada."
        exit 1
    fi

    echo -e "\n⚠️ AVISO: Vão ser alteradas as seguintes utilities no teu ~/.config:"
    for u in "${selected_utils[@]}"; do
        echo " - $u"
    done

    read -p "Queres continuar? (s/n): " confirm
    if [[ $confirm == [sS]* ]]; then
        echo -e "\n A instalar utilities selecionadas..."
        for item in "${selected_utils[@]}"; do
            if [ "$item" == "fish" ]; then
                echo -e "\n A configurar o Fish base..."
                backup_and_link "$REPO_DIR/fish" "$CONFIG_DIR/fish"

                mkdir -p "$CONFIG_DIR/fish/conf.d"
                backup_and_link "$REPO_DIR/shared/logic.fish" "$CONFIG_DIR/fish/conf.d/logic.fish"
                backup_and_link "$REPO_DIR/shared/prompt.fish" "$CONFIG_DIR/fish/conf.d/prompt.fish"
            else
                backup_and_link "$REPO_DIR/$item" "$CONFIG_DIR/$item"
            fi
        done
        sed -i 's/^ACTIVE_ENVIRONMENT=.*/ACTIVE_ENVIRONMENT="utilities"/' .dotfiles.env
        echo "✨ Utilities atualizadas com sucesso!"
    else
        echo "Operação cancelada."
        exit 1
    fi
}

clear
echo "==========================="
echo "    Dotfiles Manager 🛠️    "
echo "==========================="
echo ""
echo "Selecione o ambiente que deseja instalar:"
echo ""
echo "1) Caelestia Shell"
echo "2) End4-pC"
echo "3) Apenas Utilities (Ignora WMs e Shells)"
read -p "> " choice

case $choice in
    1)
        install_caelestia
        ;;
    2)
        install_end4
        ;;
    3)
        install_interactive_utilities
        ;;
    *)
        echo "Opção inválida."
        exit 1
        ;;
esac

echo -e "\n Instalação concluída com sucesso! Podes precisar de reiniciar a shell."
