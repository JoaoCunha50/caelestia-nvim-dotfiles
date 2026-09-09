#!/bin/bash

if [ ! -f .dotfiles.env ]; then
    echo "Erro: Ficheiro .dotfiles.env não encontrado. Corre o install.sh primeiro."
    exit 1
fi

source "$PWD/.dotfiles.env"

cd "$REPO_DIR" || exit
clear
echo "======================================"
echo "    Sincronização de Dotfiles 🚀    "
echo "======================================"

echo -e "\nO ambiente atual registado é: \033[1;36m[$ACTIVE_ENVIRONMENT]\033[0m"
read -p "Isto está correto? (s/n): " confirm_env

if [[ $confirm_env != [sS]* ]]; then
    echo -e "\nQual é o ambiente de onde pretendes guardar as alterações?"
    echo "1) Caelestia Shell"
    echo "2) End4-pC"
    echo "3) Apenas Utilities (ignorando ficheiros específicos de WM/Shell)"
    read -p "> " env_choice

    case $env_choice in
        1)
            ACTIVE_ENVIRONMENT="caelestia"
            ;;
        2)
            ACTIVE_ENVIRONMENT="end4"
            ;;
        3)
            ACTIVE_ENVIRONMENT="utilities"
            ;;
        *)
            echo "Opção inválida. Operação cancelada."
            exit 1
            ;;
    esac

    sed -i "s/^ACTIVE_ENVIRONMENT=.*/ACTIVE_ENVIRONMENT=\"$ACTIVE_ENVIRONMENT\"/" .dotfiles.env
    echo "✔ Ambiente atualizado para: [$ACTIVE_ENVIRONMENT]"
fi

echo -e "\nA verificar ficheiros alterados..."

if [[ -z $(git status -s) ]]; then
    echo "✨ Tudo atualizado! Nenhuma alteração encontrada no teu ~/.config que precise de ser enviada."
    exit 0
fi

echo -e "\nFicheiros que vão ser guardados:"
git status -s

echo -e "\nA preparar commit..."
git add .

read -p "Mensagem de commit (Deixa em branco para usar a pré-definida): " commit_msg

if [ -z "$commit_msg" ]; then
    commit_msg="Update configs ($ACTIVE_ENVIRONMENT) - $(date +'%Y-%m-%d %H:%M')"
fi

git commit -m "$commit_msg"
git push

echo -e "\n✅ Sucesso! As tuas configurações (\033[1;36m[$ACTIVE_ENVIRONMENT]\033[0m) foram enviadas para o repositório remotamente!"
