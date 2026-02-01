return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        input = { enabled = true },
        lazygit = { enabled = true },
        gitbrowse = { enabled = true },
        image = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
    },
    keys = {
        { "<leader>gg", function() Snacks.lazygit() end,   desc = "Lazygit" },
        { "<leader>gb", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    }
}
