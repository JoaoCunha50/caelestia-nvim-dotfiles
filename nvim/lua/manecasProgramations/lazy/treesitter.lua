return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        config = function()
            local ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query",
                "markdown", "markdown_inline", "javascript",
                "typescript", "tsx", "go", "rust", "bash"
            }

            local api = require("nvim-treesitter.install")
            local function install_missing()
                for _, lang in ipairs(ensure_installed) do
                    if not require("nvim-treesitter.parsers").has_parser(lang) then
                        api.ensure_installed({ lang })
                    end
                end
            end
            pcall(install_missing)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local buf = args.buf
                    pcall(vim.treesitter.start, buf)
                end,
            })
        end
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 3,
                trim_scope = "outer",
                mode = "cursor",
            })
        end
    }
}
