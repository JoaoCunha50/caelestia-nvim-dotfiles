vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m'>+1<CR>gv=gv")

-- Pesquisa (n / N) mantendo o cursor no meio
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste sem perder o buffer (preserva o que copiaste antes)
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Substituir a palavra onde estás (Search and Replace rápido)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- kitty sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !kitten @ launch --type=overlay ~/.local/bin/kitty-sessionizer<CR>")

-- Tornar o ficheiro executável (chmod +x)
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>")
