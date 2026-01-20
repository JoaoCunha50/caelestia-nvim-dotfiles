return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "vimdoc", "javascript", "typescript", "c", "lua",
                "rust", "bash", "go", "html", "templ", "tsx", "css",
                "markdown", "markdown_inline", "json", "jsonc"
            })

            -- Ativar highlighting com FileType autocmd (nova forma)
            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    "javascript", "typescript", "c", "lua", "rust",
                    "bash", "go", "html", "templ", "typescriptreact",
                    "css", "markdown", "json", "jsonc"
                },
                callback = function(args)
                    -- Verificar tamanho do ficheiro
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))

                    if ok and stats and stats.size > max_filesize then
                        vim.notify(
                            "File larger than 100KB, treesitter disabled for performance",
                            vim.log.levels.WARN,
                            { title = "Treesitter" }
                        )
                        return
                    end

                    -- Ativar highlighting (nova API do Neovim)
                    vim.treesitter.start()
                end,
            })

            -- Registar a linguagem templ
            vim.treesitter.language.register("templ", "templ")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesitter-context").setup({
                enable = true,
                multiwindow = false,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                zindex = 20,
            })
        end,
    },
}
