return {
    "NickvanDyke/opencode.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            "folke/snacks.nvim",
            opts = {
                input = {},
                picker = {},
                terminal = {}
            }
        },
    },
    keys = {
        {
            "<leader>oa",
            function()
                require("opencode").ask("@this: ")
            end,
            mode = { "n", "v" },
            desc = "Opencode: Ask"
        },
        {
            "<leader>os",
            function()
                require("opencode").select()
            end,
            mode = { "n", "v" },
            desc = "Opencode: Select Action"
        },
        -- Adicionar range ao opencode
        {
            "go",
            function()
                return require("opencode").operator("@this ")
            end,
            mode = { "n", "x" },
            expr = true,
            desc = "Opencode: Add range"
        },
        -- Adicionar linha ao opencode
        {
            "goo",
            function()
                return require("opencode").operator("@this ") .. "_"
            end,
            mode = "n",
            expr = true,
            desc = "Opencode: Add line"
        },
        -- Toggle do terminal
        {
            "<C-.>",
            function()
                require("opencode").toggle()
            end,
            mode = { "n", "t", "v" },
            desc = "Opencode: Toggle terminal"
        },
        -- Scroll no opencode
        {
            "<S-C-u>",
            function()
                require("opencode").command("session.half.page.up")
            end,
            mode = "n",
            desc = "Opencode: Scroll up"
        },
        {
            "<S-C-d>",
            function()
                require("opencode").command("session.half.page.down")
            end,
            mode = "n",
            desc = "Opencode: Scroll down"
        },
    },
    config = function()
        -- Encontrar o path do opencode
        local opencode_path = vim.fn.exepath("opencode")

        if opencode_path == "" then
            local possible_paths = {
                vim.fn.expand("$HOME/.local/bin/opencode"),
                "/usr/local/bin/opencode",
                "/usr/bin/opencode",
            }

            for _, path in ipairs(possible_paths) do
                if vim.fn.executable(path) == 1 then
                    opencode_path = path
                    break
                end
            end
        end

        ---@type opencode.Opts
        vim.g.opencode_opts = {
            provider = {
                enabled = "snacks",
                snacks = {
                    cmd = opencode_path ~= "" and opencode_path or "opencode",
                    args = { "--port" },
                    win = {
                        position = "float", -- "bottom", "right", "left", "top", "float"
                        width = 0.85,
                        height = 0.85,
                        border = "rounded",
                        backdrop = 0.6,
                        zindex = 50,
                        enter = true,
                    },
                },
            },
            events = {
                reload = true,
            },
            input = {
                enabled = "snacks",
                snacks = {
                    border = "rounded",
                    title = "OpenCode",
                    history = true,
                },
            },
            picker = {
                enabled = "snacks",
                snacks = {
                    preview = true,
                },
            },
        }

        vim.o.autoread = true

        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "*opencode*",
            callback = function()
                vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { buffer = true, silent = true })
                vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { buffer = true, silent = true })
                vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { buffer = true, silent = true })
                vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { buffer = true, silent = true })
            end,
        })

        vim.api.nvim_create_autocmd("FileChangedShellPost", {
            callback = function(args)
                Snacks.notify.info("AI Editou: " .. vim.fn.fnamemodify(vim.fn.expand("<afile>"), ":t"),
                    { title = "Opencode" })
                if vim.api.nvim_get_current_buf() ~= args.buf then
                    vim.api.nvim_set_current_buf(args.buf)
                end
            end,
        })
    end
}
