function ColorMyPencils(color)
    color = color or "tokyonight-night"
    vim.cmd.colorscheme(color)
end

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = false },
                    keywords = { italic = false },
                    sidebars = "dark",
                    floats = "dark",
                },
            })

            -- ColorMyPencils("tokyonight-night")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                variant = "main",
                dark_variant = "main",
                dim_inactive_windows = false,
                extend_background_behind_borders = true,
                styles = {
                    bold = true,
                    italic = false,
                    transparency = true,
                },
            })

            ColorMyPencils("rose-pine")
        end
    },
    {
        -- {
        --     "Ferouk/bearded-nvim",
        --     name = "bearded",
        --     priority = 1000,
        --     build = function()
        --         -- Generate helptags so :h bearded-theme works
        --         local doc = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "bearded", "doc")
        --         pcall(vim.cmd, "helptags " .. doc)
        --     end,
        --     config = function()
        --         require("bearded").setup({
        --             flavor = "feat-mellejulie", -- any flavor slug
        --             transparent = true,
        --             terminal_colors = true,
        --             bold = true,
        --             italic = false,
        --             on_highlights = function(set, palette)
        --                 set("NormalFloat", { bg = palette.ui.uibackgroundalt })
        --                 set("NvimTreeNormal", { bg = palette.ui.uibackgroundalt })
        --                 set("NeoTreeNormal", { fg = palette.ui.default, bg = palette.ui.uibackgroundalt })
        --             end,
        --         })
        --
        --         -- ColorMyPencils("bearded")
        --     end,
        -- }
    }
}
