return {
    {
        "igorlfs/nvim-dap-view",
        ---@module 'dap-view'
        ---@type dapview.Config
        opts = {
            winbar = {
                sections = { "console", "watches", "scopes", "exceptions", "breakpoints", "threads", "repl" },
                default_section = "console",
                custom_sections = {},
                controls = {
                    enabled = true,
                    position = "right",
                    buttons = {
                        "play",
                        "step_into",
                        "step_over",
                        "step_out",
                        "step_back",
                        "run_last",
                        "terminate",
                        "disconnect",
                        "fun",
                    },
                    custom_buttons = {
                        fun = {
                            render = function()
                                return "🎉"
                            end,
                            action = function()
                                vim.print("🎊")
                            end,
                        },
                    },
                },
            },

            windows = {
                -- `prev` is the last used position, might be nil
                position = function(prev)
                    local wins = vim.api.nvim_tabpage_list_wins(0)

                    -- Restores previous position if terminal is visible
                    if
                        vim.iter(wins):find(function(win)
                            return vim.w[win].dapview_win_term
                        end)
                    then
                        return prev
                    end

                    return vim.tbl_count(vim.iter(wins)
                        :filter(function(win)
                            local buf = vim.api.nvim_win_get_buf(win)
                            local valid_buftype =
                                vim.tbl_contains({ "", "help", "prompt", "quickfix", "terminal" }, vim.bo[buf].buftype)
                            local dapview_win = vim.w[win].dapview_win or vim.w[win].dapview_win_term
                            return valid_buftype and not dapview_win
                        end)
                        :totable()) > 1 and "below" or "right"
                end,
                size = function(pos)
                    return pos == "below" and 0.25 or 0.5
                end,
                terminal = {
                    -- `pos` is the position for the regular window
                    position = function(pos)
                        return pos == "below" and "right" or "below"
                    end,
                    size = 0.5,
                },
            },
        },
    },
}
