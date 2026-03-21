return {
    "fnune/recall.nvim",
    config = function()
        require("recall").setup {}
        vim.keymap.set("n", "<leader>rt", ":Telescope recall<CR>")
        vim.keymap.set("n", "<leader>rb", ":RecallToggle<CR>")
    end,
}
