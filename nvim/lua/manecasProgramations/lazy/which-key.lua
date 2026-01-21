return {
    "folke/which-key.nvim",
    event = "VimEnter",
    opts = {
        delay = 0,
        icons = {
            mappings = true,
        },
        spec = {
            { "<leader>s", group = "[S]earch" },
            { "<leader>g", group = "[G]it" },
            { "<leader>l", group = "[L]SP" },
            { "<leader>t", group = "[T]oggle" },
        },
    },
}
