return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "stevearc/conform.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("conform").setup({
            formatters_by_ft = {
            }
        })
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")

        -- 1. Capabilities: Tell the servers we support advanced autocomplete
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            -- Ir para a definição (Go to Definition)
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            -- Ver informação sobre a função (Hover)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
            -- Pesquisar workspace symbol
            vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
            -- Ver diagnósticos (erros) numa janela flutuante
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            -- Ir para o erro seguinte/anterior
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            -- Code Action (Sugestões de correção rápida)
            vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
            -- References (Quem usa esta função?)
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            -- RENAME (Mudar o nome da variável em todo o projeto)
            vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)
            -- Ajuda na assinatura da função (parâmetros)
            vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end

	    require("fidget").setup({
		    notification = {
			    window = {
				    normal_hl = "Normal",
				    winblend = 0,
			    },
		    },
	    })
	    require("mason").setup()

        -- 2. Mason LSP Config: The "Magic" Part
        require("mason-lspconfig").setup({
            -- List of servers to install automatically
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "vtsls",
                "tailwindcss",
            },
            handlers = {
                -- This function is called for every server installed above.
                function(server_name)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        -- 3. Autocomplete Setup
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "copilot", group_index = 2 },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

        -- 4. Diagnostics UI (Pretty errors)
        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
