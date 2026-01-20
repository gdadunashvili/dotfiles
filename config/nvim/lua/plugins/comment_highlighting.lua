return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        -- ToDo: example
        -- myToDo: example
        -- gToDo: example
        -- TODO: another example
        -- todo: another example
        -- FIX: another example
        -- PERF: too slow
        -- WARN: sth bad is gonna happen
        -- NOTE: stop configuring and go back to work
        -- TEST: nothing to test 🤷
        signs = false,
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below

        highlight = {
            multiline = true,                                                 -- enable multine todo comments
            multiline_pattern = "^.",                                         -- lua pattern to match the next multiline from the start of the matched keyword
            multiline_context = 10,                                           -- extra lines that will be re-evaluated when changing a line
            before = "",                                                      -- "fg" or "bg" or empty
            keyword = "wide",                                                 -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
            after = "fg",                                                     -- "fg" or "bg" or empty
            pattern = { [[.*<(KEYWORDS)\s*:]], [[.*<(KEYWORDS)\s*\(.*\):]] }, -- pattern or table of patterns, used for highlighting (vim regex)
            comments_only = true,                                             -- uses treesitter to match keywords in comments only
            max_line_len = 400,                                               -- ignore lines longer than this
            exclude = {},                                                     -- list of file types to exclude highlighting
        },
        keywords = {
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            gtodo = { icon = " ", color = "mytodo", alt = { "myToDo", "mytodo", "gToDo", "gTODO" } },
            TODO = { icon = " ", color = "info", alt = { "todo", "ToDo" } },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },

        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            mytodo = { "MyToDoInfo", "#FF000B" },
            hint = { "DiagnosticHint", "#08F43F" },
            default = { "Identifier", "#7C3AED" },
            test = { "Test", "#18a9E1" },
        },
    }
}
