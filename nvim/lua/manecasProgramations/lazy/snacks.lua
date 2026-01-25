return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        animate = {
            enabled = true,
            duration = 150,     -- Mais suave (150ms)
            easing = "outQuad", -- Easing mais natural
            fps = 60,           -- Frame rate
        },
        bigfile = { enabled = true },
        input = { enabled = true },
        lazygit = { enabled = true },
        gitbrowse = { enabled = true },
        image = { enabled = true },
        notifier = { enabled = true }, -- Substitui o 'nvim-notify'
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        { "<leader>gg", function() Snacks.lazygit() end,   desc = "Lazygit" },
        { "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    }
}
