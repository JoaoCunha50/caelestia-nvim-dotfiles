return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED: Setup do harpoon
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
                key = function()
                    -- Usar o diretório atual como key (cada projeto tem os seus marks)
                    return vim.loop.cwd()
                end,
            },
        })

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end,
            { desc = "Harpoon: Add file" })

        -- Toggle UI do harpoon (ver todos os ficheiros marcados)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon: Toggle menu" })

        -- Navegar para ficheiros específicos (1-4)
        vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end,
            { desc = "Harpoon: Go to file 1" })
        vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end,
            { desc = "Harpoon: Go to file 2" })
        vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end,
            { desc = "Harpoon: Go to file 3" })
        vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end,
            { desc = "Harpoon: Go to file 4" })

        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end,
            { desc = "Harpoon: Previous file" })
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end,
            { desc = "Harpoon: Next file" })

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end,
            { desc = "Open harpoon window in Telescope" })
    end,
}
