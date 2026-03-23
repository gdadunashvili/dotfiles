return {
    "fnune/recall.nvim",
    config = function()
        local recall = require("recall")
        recall.setup({
            sign = "",
            sign_highlight = "@comment.note",

            telescope = {
                autoload = true,
                mappings = {
                    unmark_selected_entry = {
                        normal = "dd",
                        insert = "",
                    },
                },
            },
        })

        vim.keymap.set("n", "mm", recall.toggle, { noremap = true, silent = true })
        vim.keymap.set("n", "mj", recall.goto_next, { noremap = true, silent = true })
        vim.keymap.set("n", "mk", recall.goto_prev, { noremap = true, silent = true })
        vim.keymap.set("n", "ml", ":Telescope recall<CR>", { noremap = true, silent = true })
    end,
}
