return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true, -- Fecha se for a última janela
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,

            default_component_configs = {
                indent = {
                    indent_size = 2,
                    padding = 2,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    with_expanders = true,
                    expander_collapsed = "",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                },
               git_status = {
                    symbols = {
                        added     = "✚",
                        modified  = "",
                        deleted   = "✖",
                        renamed   = "󰁕",
                        untracked = "",
                        ignored   = "",
                        unstaged  = "󰄱",
                        staged    = "",
                        conflict  = "",
                    }
                },
            },

            window = {
                position = "left",
                width = 30,
                mapping_options = {
                    noremap = true,
                    nowait = true,
                },
                mappings = {
                    ["<space>"] = {
                        "toggle_node",
                        nowait = false,
                    },
                    ["<2-LeftMouse>"] = "open",
                    ["l"] = "open",
                    ["h"] = "close_node",
                    ["s"] = "open_vsplit",
                    ["t"] = "open_tabnew",
                    ["z"] = "close_all_nodes",
                    ["a"] = {
                        "add",
                        config = {
                            show_path = "none"
                        }
                    },
                    ["A"] = "add_directory",
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy",
                    ["m"] = "move",
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                },
            },

            filesystem = {
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_by_name = {
                        "node_modules",
                        ".git",
                        ".DS_Store",
                    },
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
                use_libuv_file_watcher = true,
                window = {
                    mappings = {
                        ["<bs>"] = "navigate_up",
                        ["."] = "set_root",
                        ["H"] = "toggle_hidden",
                        ["/"] = "fuzzy_finder",
                        ["<c-x>"] = "clear_filter",
                        ["[g"] = "prev_git_modified",
                        ["]g"] = "next_git_modified",
                    },
                },
            },

            event_handlers = {
                {
                    event = "file_opened",
                    handler = function()
                        -- Fecha a sidebar quando abres um ficheiro
                        require("neo-tree.command").execute({ action = "close" })
                    end
                },
            },
        })

        -- Keybindings
        vim.keymap.set("n", "<leader>b", ":Neotree toggle<CR>", { silent = true, desc = "Toggle Neo-tree" })
        vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { silent = true, desc = "Focus Neo-tree" })
    end,
}
