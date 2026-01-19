return {
    -- 1. TPope's Fugitive (O "pai" do Git no Vim)
    -- Serve para comandos: :Git commit, :Git push, :Gdiffsplit
    {
        "tpope/vim-fugitive",
        config = function()
            -- <leader>gs abre o menu do Git (tipo status)
            vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        end
    },

    -- Mete linhas verdes/vermelhas na coluna lateral quando mudas algo
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup({
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
            })

            -- Atalho para ver o diff da linha atual numa janela flutuante
            vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", {})
            -- Atalho para fazer "blame" na linha (quem escreveu isto?)
            vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", {})
        end
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'tokyonight', -- Integração perfeita com o teu tema
                    icons_enabled = true,
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                },
                sections = {
                    -- Mostra: Modo | Branch Git | Diff status | Diagnósticos
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
            })
        end
    }
}
