-- lazy.nvim
return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        picker = { enabled = true, },
        image = { enabled = true, },
        statuscolumn = {
            enabled = true,
            left = { "sign", "mark" }, -- priority of signs on the left (high to low)
            right = { "fold", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = false,          -- show open fold icons
                git_hl = true,         -- use Git Signs hl for fold icons
            },
            refresh = 50,              -- refresh at most every 50ms
        },
    },
    gitbrowse = {},
    terminal = {},
    term_normal = {
        "<esc>",
        function(self)
            self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
            if self.esc_timer:is_active() then
                self.esc_timer:stop()
                vim.cmd("stopinsert")
            else
                self.esc_timer:start(200, 0, function() end)
                return "<esc>"
            end
        end,
        mode = "t",
        expr = true,
        desc = "Double escape to normal mode",
    },
    keys = {
        { "<leader>gi", function() Snacks.picker.gh_issue() end,                  desc = "GitHub Issues (open)" },
        { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
        { "<leader>gp", function() Snacks.picker.gh_pr() end,                     desc = "GitHub Pull Requests (open)" },
        { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end,    desc = "GitHub Pull Requests (all)" },
        { "<leader>gB", function() Snacks.gitbrowse() end,                        desc = "Git Browse",                 mode = { "n", "v" } },

        { "<c-/>",      function() Snacks.terminal() end,                         desc = "Toggle Terminal",            mode = { "n", "v", "t", "i" } },
        { "<F1>",       function() vim.cmd("stopinsert") end,                     desc = "Toggle Terminal",            mode = { "n", "v", "t", "i" } },
    }
}
