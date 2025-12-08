return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {
        custom_key_maps = {
            { "n", "<Leader>|", function() require("multiple-cursors").align() end },
        },
    }, -- This causes the plugin setup function to be called
    keys = {
        { "<C-S-j>",       "<Cmd>MultipleCursorsAddDown<CR>",        mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
        { "<C-S-k>",       "<Cmd>MultipleCursorsAddUp<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
        { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",          mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
        { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",        mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
        { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" },      desc = "Add or remove cursor" },
        { "<Leader>vv",    "<Cmd>MultipleCursorsAddVisualArea<CR>",  mode = { "x" },           desc = "Add cursors to the lines of the visual area" },

        { "<Leader>va",    "<Cmd>MultipleCursorsAddMatches<CR>",     mode = { "n", "x" },      desc = "Add cursors to cword" },
        { "<Leader>vA",    "<Cmd>MultipleCursorsAddMatchesV<CR>",    mode = { "n", "x" },      desc = "Add cursors to cword in previous area" },

        { "<Leader>vl",    "<Cmd>MultipleCursorsLock<CR>",           mode = { "n", "x" },      desc = "Lock virtual cursors" },
    },
}
