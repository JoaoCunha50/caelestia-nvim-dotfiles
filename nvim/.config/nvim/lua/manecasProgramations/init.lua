require("manecasProgramations.set")
require("manecasProgramations.remap")
require("manecasProgramations.lazy_nvim")

local augroup = vim.api.nvim_create_augroup
local manecasGroup = augroup('manecasProgramations', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = manecasGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
