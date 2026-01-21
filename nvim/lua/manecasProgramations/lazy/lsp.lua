return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "j-hui/fidget.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            local lspconfig = require("lspconfig")

            require("fidget").setup({})
            require("mason").setup()

            local function client_supports_method(client, method, bufnr)
                if vim.fn.has 'nvim-0.11' == 1 then
                    return client:supports_method(method, bufnr)
                else
                    return client.supports_method(method, { bufnr = bufnr })
                end
            end

            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "rust_analyzer", "gopls", "vtsls", "tailwindcss" },
                handlers = {
                    function(server_name)
                        lspconfig[server_name].setup({ capabilities = capabilities })
                    end,
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = { Lua = { diagnostics = { globals = { 'vim' } } } }
                        })
                    end,
                }
            })

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach-opts', { clear = true }),
                callback = function(e)
                    local opts = { buffer = e.buf }

                    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                    vim.keymap.set("n", "[d", function() vim.diagnostic.get_next() end, opts)
                    vim.keymap.set("n", "]d", function() vim.diagnostic.get_prev() end, opts)

                    -- Toggle Inlay Hints
                    vim.keymap.set('n', '<leader>th', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = e.buf }))
                    end, { buffer = e.buf, desc = '[T]oggle Inlay [H]ints' })

                    -- CursorHold: Iluminar referências
                    local client = vim.lsp.get_client_by_id(e.data.client_id)
                    if client and client_supports_method(client, 'textDocument/documentHighlight', e.buf) then
                        local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = e.buf, group = group, callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = e.buf, group = group, callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })
        end
    },
    {
        'saghen/blink.cmp',
        version = 'v0.*',
        opts = {
            keymap = { preset = 'default' },
            appearance = { nerd_font_variant = 'mono' },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'lazydev' },
                providers = {
                    lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
                },
            },
            signature = { enabled = true },
        },
    }
}
