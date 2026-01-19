return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            view = {
                width = 30,
                side = "left",
            },
            filters = {
                dotfiles = false, -- Mostra ficheiros .config, .env, etc
            },
        })

        vim.keymap.set("n", "<leader>b", ":NvimTreeToggle<CR>", { silent = true })
    end,
}
