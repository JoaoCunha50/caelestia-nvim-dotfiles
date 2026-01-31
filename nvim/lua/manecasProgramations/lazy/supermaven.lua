return {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
        require("supermaven-nvim").setup({
            keymaps = {
                accept_suggestion = "<Tab>",
                clear_suggestion = "<C-x>",
                accept_word = "<C-j>",
            },
            ignore_filetypes = {},
        })
    end
}
