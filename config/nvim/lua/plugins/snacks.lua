-- lazy.nvim
return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        terminal = {
            auto_insert = false,
            win_enter = false,
            start_insert = false,
        },
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
        dim = {
            scope = {
                min_size = 5,
                max_size = 20,
                siblings = true,
            },
        },
    },
    gitbrowse = {},
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
        { "<leader>gi",       function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
        { "<leader>gI",       function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
        { "<leader>gp",       function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
        { "<leader>gP",       function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
        { "<leader>gB",       function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },

        { "<c-/>",            function() Snacks.terminal() end,                                       desc = "Toggle Terminal",            mode = { "n", "v", "t", "i" } },
        { "<c-;>",            function() Snacks.terminal.open() end,                                  desc = "Toggle Terminal",            mode = { "n", "v", "t", "i" } },


        { '<leader>ff',       function() Snacks.picker.files() end,                                   desc = '[F]ind [K]eymaps' },
        { '<leader><leader>', function() Snacks.picker.smart() end,                                   desc = '[F]ind [K]eymaps' },
        { "<leader>fn",       function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
        {
            "<leader>1",
            function()
                vim.api.nvim_create_autocmd('BufWinEnter', {
                    group = vim.api.nvim_create_augroup('snacks_explorer_autorefresh', { clear = true }),
                    callback = function(event)
                        local picker = Snacks.picker.get({ source = 'explorer' })[1]
                        if not picker then return end
                        local E = require 'snacks.explorer'
                        E.reveal({ buf = event.buf })
                    end,
                })
                Snacks.explorer()
            end,
            desc = "File Explorer"
        },

        { '<leader>fk', function() Snacks.picker.keymaps() end,     desc = '[F]ind [K]eymaps' },
        { '<leader>fh', function() Snacks.picker.help() end,        desc = '[F]ind [H]elp' },
        -- gToDo: this needs a good replacement
        -- { '<leader>fs',       function() Snacks.picker.builtin() end,     desc = '[F]ind [S]elect Telescope' },
        { '<leader>fm', function() Snacks.picker.marks() end,       desc = '[F]ind [M]arks' },
        { '<leader>fj', function() Snacks.picker.jumps() end,       desc = '[F]ind [J]jumps' },
        { '<c-p>',      function() Snacks.picker.commands() end,    desc = '[F]ind [S]elect Telescope' },
        { '<leader>fd', function() Snacks.picker.diagnostics() end, desc = '[F]ind [D]iagnostics' },
        { '<leader>fr', function() Snacks.picker.resume() end,      desc = '[F]ind [R]esume' },
        { "<leader>su", function() Snacks.picker.undo() end,        desc = "Undo History" },

        { '<leader>f.', function() Snacks.picker.buffers() end,     desc = '[F]ind Recent Files ("." for repeat)' },
        { '<leader>fg', function() Snacks.picker.grep() end,        desc = '[F]ind [G]rep' },

    }
}
