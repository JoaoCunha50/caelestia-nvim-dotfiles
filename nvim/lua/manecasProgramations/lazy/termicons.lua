return {
    "mskelton/termicons.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    build = false,
    lazy = false,
    priority = 1000,
    config = function()
        require("termicons").setup()
    end,
}
