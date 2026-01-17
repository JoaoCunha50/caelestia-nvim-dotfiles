return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
    -- O 'config = true' é o mesmo que fazer:
    -- config = function()
    --   require("nvim-autopairs").setup({})
    -- end
}
