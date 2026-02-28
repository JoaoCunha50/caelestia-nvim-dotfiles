return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },

    build = "cd app && npm install",

    keys = {
        {
            "<leader>mp",
            ft = "markdown",
            "<cmd>MarkdownPreviewToggle<cr>",
            desc = "Toggle Markdown Preview",
        },
    },
    config = function()
        vim.g.mkdp_theme = 'dark'
    end,
}
