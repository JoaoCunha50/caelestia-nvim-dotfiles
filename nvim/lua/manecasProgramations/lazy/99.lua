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
            model = "opencode/big-pickle"
        })
        vim.keymap.set("v", "<leader>9vv", function()
            _99.visual()
        end)
        vim.keymap.set("v", "<leader>9vp", function()
            _99.visual_prompt()
        end)
        vim.keymap.set("n", "<leader>9s", function()
            _99.stop_all_requests()
        end)
        vim.keymap.set("n", "<leader>9i", function()
            _99.info()
        end)
        vim.keymap.set("n", "<leader>9l", function()
            _99.view_logs()
        end)
    end,
}
