-- lazy.nvim
return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        picker = { enabled = true, },
        image = { enabled = true, },
    },
    gitbrowse = {},
    terminal = {
        -- your terminal configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    keys = {
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse",      mode = { "n", "v" } },
        { "<c-/>",      function() Snacks.terminal() end,  desc = "Toggle Terminal" },
        { "<c-_>",      function() Snacks.terminal() end,  desc = "which_key_ignore" },
    }
}
