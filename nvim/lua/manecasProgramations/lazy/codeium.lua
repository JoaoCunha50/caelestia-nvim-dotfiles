return {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
        -- Desativa os atalhos padrão para definirmos os nossos
        vim.g.codeium_disable_bindings = 1
        -- <C-g> aceita a sugestão
        vim.keymap.set('i', '<Tab>', function() return vim.fn['codeium#Accept']() end,
            { expr = true, silent = true })
        -- <C-x> limpa a sugestão
        vim.keymap.set('i', '<C-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
    end
}
