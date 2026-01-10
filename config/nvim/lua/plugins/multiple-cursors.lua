return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    post_hook = function()
        -- Set MultipleCursorsCursor to be slightly darker than Cursor
        local cursor = vim.api.nvim_get_hl(0, { name = "Cursor" })
        cursor.bg = cursor.bg - 3355443 -- -#333333
        vim.api.nvim_set_hl(0, "MultipleCursorsCursor", cursor)

        -- Set MultipleCursorsVisual to be slightly darker than Visual
        local visual = vim.api.nvim_get_hl(0, { name = "Visual" })
        visual.bg = visual.bg - 1118481 -- -#111111
        vim.api.nvim_set_hl(0, "MultipleCursorsVisual", visual)
    end,
    opts = {
        custom_key_maps = {
            { "n", "<Leader>|", function() require("multiple-cursors").align() end },
        },
    }, -- This causes the plugin setup function to be called
    keys = {
        { "<C-S-j>",       "<Cmd>MultipleCursorsAddDown<CR>",        mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
        { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",        mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
        { "<C-S-k>",       "<Cmd>MultipleCursorsAddUp<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
        { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
        { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" },      desc = "Add or remove cursor" },
        { "<Leader>vv",    "<Cmd>MultipleCursorsAddVisualArea<CR>",  mode = { "x" },           desc = "Add cursors to the lines of the visual area" },

        { "<Leader>va",    "<Cmd>MultipleCursorsAddMatches<CR>",     mode = { "n", "x" },      desc = "Add cursors to cword" },

        { "<Leader>vl",    "<Cmd>MultipleCursorsLock<CR>",           mode = { "n", "x" },      desc = "Lock virtual cursors" },
    },
}
