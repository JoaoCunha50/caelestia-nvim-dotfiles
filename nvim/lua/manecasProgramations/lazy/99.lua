return {
    "ThePrimeagen/99",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local _99 = require("99")
        local md_path = os.getenv("HOME")
        _99.setup({
            md_files = {
                md_path .. "/dev/personal/skills/REFACTOR.md",
                md_path .. "/dev/personal/skills/GOLANG.md"
            },
        })
        vim.keymap.set("n", "<leader>9f", function()
            _99.fill_in_function()
        end)
        -- take extra note that i have visual selection only in v mode
        -- technically whatever your last visual selection is, will be used
        -- so i have this set to visual mode so i dont screw up and use an
        -- old visual selection
        --
        -- likely ill add a mode check and assert on required visual mode
        -- so just prepare for it now
        vim.keymap.set("v", "<leader>9v", function()
            _99.visual()
        end)

        --- if you have a request you dont want to make any changes, just cancel it
        vim.keymap.set("v", "<leader>9s", function()
            _99.stop_all_requests()
        end)

        --- Example: Using rules + actions for custom behaviors
        --- Create a rule file like ~/.rules/debug.md that defines custom behavior.
        --- For instance, a "debug" rule could automatically add printf statements
        --- throughout a function to help debug its execution flow.
        -- vim.keymap.set("n", "<leader>9fd", function()
        --     _99.fill_in_function()
        -- end)
    end,
}
