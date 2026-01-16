return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    settings = {
        save_in_toggle = true,
    },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>m", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>M", function() harpoon:list():prepend() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end)
    end,
}
