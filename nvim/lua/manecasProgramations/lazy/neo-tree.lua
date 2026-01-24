return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>b", ":Neotree toggle<CR>", desc = "Toggle Neo-tree", silent = true },
    },
    opts = {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        window = {
            position = "left",
            width = 30,
            mappings = {
                ["<space>"] = { "toggle_node", nowait = false },
                ["l"] = "open",
                ["h"] = "close_node",
            },
        },
        filesystem = {
            filtered_items = {
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                hide_by_name = { "node_modules", ".git" },
            },
            follow_current_file = { enabled = true },
            use_libuv_file_watcher = true,
        },
        event_handlers = {
            {
                event = "file_opened",
                handler = function()
                    require("neo-tree.command").execute({ action = "close" })
                end
            },
        },
        default_component_configs = {
            indent = {
                with_expanders = true,
                expander_collapsed = "",
                expander_expanded = "",
            },
        },
    },
}
